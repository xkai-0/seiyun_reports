import 'dart:io';

import 'package:dio/dio.dart';
import 'package:seiyun_reports_app/core/utils/pref_helper.dart';
import 'package:seiyun_reports_app/screens/report/data/report_model.dart';
import 'package:seiyun_reports_app/screens/report/data/report_service.dart';

class ReportRepository {
  final ReportService _reportService;
  ReportRepository(this._reportService);
  //دالة ارسال بلاغ للسيرفر 
Future<bool> sendNewReport({
    required String description,
    required String title,
    required String type,
    required String priority,
    required String lat,
    required String lng,
    required File imageFile, 
  }) async {
    try {
      // لان اليوزر ايدي متخزن بالشيرد برفرنس 
      int? userId = await PrefHelper.getUserId();
    
      // FormData لانه يحتوي على ملف صوره
      FormData formData = FormData.fromMap({
        "citizen_id": userId,//ربط البلاغ بهوية المستخدم 
        "title": title,
        "description": description,
        "report_type": type,
        "priority": priority,
        "lat": lat,
        "lng": lng,
        "image": await MultipartFile.fromFile(
          imageFile.path, // تحويل مسار الصورة الى ملف لاجل ان يتم قبوله من السيرفر
          filename: imageFile.path.split('/').last, //استخراج اسم الملف عشان السيرفر يعرف نوعه
          contentType: DioMediaType("image", "jpeg"), // تحديد نوع البيانات المرسلة لضمان معالجتها كصورة
        ),
      });

      // ارسال البيانات وانتظار رد السيرفرس
      final response = await _reportService.createReport(formData);
      
      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {

    print("--- SERVER ERROR (500) DETAILS ---");
    if (e.response != null) {
      print("Status Code: ${e.response?.statusCode}");
      print("Error Data: ${e.response?.data}"); 
    } else {
      print("Message: ${e.message}");
    }
    return false;
  } catch (e) {
    print("General Error: $e");
    return false;
  }
}
  // دالة جلب قائمة بلاغاتي 
  Future<List<ReportModel>> fetchMyReports() async {
    try {
      final response = await _reportService.getMyReports();
      if (response.statusCode == 200) {
        List data = response.data['data']??[]; //
        return data.map((json) => ReportModel.fromJson(json)).toList();
      }
      print("Response status: ${response.statusCode} but no list found");
    return [];
    } catch (e) {
      print("Fetch Reports Error: $e");
      return [];
    }
  }
}