import 'package:flutter/material.dart';
import 'package:seiyun_reports_app/screens/citizen_reports/data/citizen_reports_repository.dart';
import 'package:seiyun_reports_app/screens/citizen_reports/data/models/report_statistics.dart';
import '../data/models/citizen_report_model.dart';

class CitizenReportsViewModel extends ChangeNotifier {
  final CitizenReportsRepository _repository;

  List<CitizenReportModel> _reports = [];
  List<CitizenReportModel> get reports => _reports;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  ReportStatistics? _stats; 
  ReportStatistics? get stats => _stats;// كائن ياخذ الاحصائيات القادمة من API


  CitizenReportsViewModel(this._repository) {
    loadDashboardData(); // استدعاءلدالة الجلب الموحدة عند التشغيل
  }
  

   Future<void> loadDashboardData() async {
    _isLoading = true;
    notifyListeners();
   try {
      //  جلب البلاغات والاحصائيات من السيرفر
      _reports = await _repository.fetchReports();
      _stats = await _repository.getReportStats();

    } catch (e) {
      print("❌ فشل الجلب: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
     

  Future< void> toggleLike(int reportId) async{
    final index = _reports.indexWhere((r) => r.id == reportId);
    if (index != -1) {
      final report = _reports[index];
      final oldStatus = report.isLiked;

      _reports[index] = report.copyWith(
        isLiked:!oldStatus,
        likesCount: oldStatus ? report.likesCount - 1 : report.likesCount + 1,
      );
      notifyListeners();
      //ارسال التحديث حق اللايك للسيرفر
      bool success = await _repository.updateLike(reportId);

      //لو فشل السيرفر يرجع حالة اللايك نفس قبل 
      if(!success){
        _reports[index]= report.copyWith(
          isLiked:  oldStatus,
          likesCount: report.likesCount,
        );
        notifyListeners();
      }
      
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<CitizenReportModel> get filteredReports {
    if (_searchQuery.isEmpty) return _reports;
    return _reports.where((r) => 
      r.title.contains(_searchQuery) || 
      r.description.contains(_searchQuery) ||
      r.description.contains(_searchQuery)
    ).toList();
  }
  //هنا يقرا البيانات من مودل الاحصائيات مالم يجدها هو يحسبها 
  int get totalReports => _stats?.total?? _reports.length;
  int get resolvedReports =>_stats?.resolved?? _reports.where((r) => r.status == 'تم الحل').length;
  int get activeReports =>_stats?.active?? _reports.where((r) => r.status != 'تم الحل').length;
  String get resolutionRate {
    if (_stats != null) {
    return _stats!.resolutionRate; 
  }

    if (_reports.isEmpty) return "0%";
   double calculatedRate = (resolvedReports / totalReports) * 100;
   return "${calculatedRate.toStringAsFixed(0)}%";
  }
}
