import 'package:dio/dio.dart';
import 'package:seiyun_reports_app/core/network/api_service.dart';

class ReportService {
  final ApiService _apiService;
  ReportService(this._apiService);

  // إرسال بلاغ جديد (POST)
  Future<Response> createReport(FormData formData, String token) async {
    return await _apiService.post(
      'reports/create', 
      data: formData,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
  }

  // جلب بلاغاتي (GET)
  Future<Response> getMyReports(String token) async {
    return await _apiService.get(
      'citizen/reports', 
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }
}