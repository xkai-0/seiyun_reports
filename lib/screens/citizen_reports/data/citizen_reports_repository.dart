import 'package:seiyun_reports_app/screens/citizen_reports/data/citizen_reports_service.dart';
import 'package:seiyun_reports_app/screens/citizen_reports/data/models/citizen_report_model.dart';
import 'package:seiyun_reports_app/screens/citizen_reports/data/models/report_statistics.dart';



class CitizenReportsRepository {
  final CitizenReportsService _service;

  // Constructor: نمرر السيرفس للمستودع (Dependency Injection)
  CitizenReportsRepository(this._service);

  // دالة جلب البيانات وتحويلها لموديلات
  Future<List<CitizenReportModel>> fetchReports() async {
    try {
      final response = await _service.getAllCitizenReports();

      // التأكد من نجاح الطلب والحالة  
    if (response.data['status'] == 'success') {
      final List list = response.data['data']; 
     // الماب تاخذ كل بلاغ وتمرره للدالة حق فروم جسون عشان يتحول لكائن وبتخزن في القائمة 
      return list.map((json) => CitizenReportModel.fromJson(json)).toList();
    } else {
      return [];
    }
      
    } catch (e) {
      print("خطأ في المستودع أثناء جلب البلاغات: $e");
      return [];
    }
  }

  // دالة تحديث اللايك في السيرفر
  Future<bool> updateLike(int reportId) async {
    try {
      final response = await _service.incrementLike(reportId);
      return response.statusCode == 200;
    } catch (e) {
      print("خطأ في تحديث اللايك: $e");
      return false;
    }
  }
  //دالة جلب الاحصائيات 
  Future<ReportStatistics?> getReportStats() async {
  try {
    final response = await _service.getStatistics();
    if (response.data['status'] == 'success') {
      return ReportStatistics.fromJson(response.data['data']);
    }
  } catch (e) {
    print("Error fetching stats: $e");
  }
  return null;
}
}