import 'dart:io';
import 'package:dio/dio.dart';
import 'package:seiyun_reports_app/core/utils/pref_helper.dart';
import '../data/report_service.dart'; 

class ReportRepository {
  final ReportService _reportService;

  ReportRepository(this._reportService);

  Future<bool> sendNewReport({
    required String description,
    required String type,
    required String lat,
    required String lng,
    required File imageFile, 
  }) async {
    try {
      // 1. جلب التوكن والايدي من الشيرد برفرنس (المجلد الأب)
      String? token = await PrefHelper.getToken();
      int? userId = await PrefHelper.getUserId();

      if (token == null) return false;

      // 2. تجهيز الـ FormData لإرسال الصورة والبيانات
      FormData formData = FormData.fromMap({
        "citizen_id": userId,
        "description": description,
        "report_type": type,
        "lat": lat,
        "lng": lng,
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      // 3. استدعاء السيرفس لإتمام العملية
      final response = await _reportService.createReport(formData, token);
      
      // إذا كان الرد 201 كما في صورتك أو 200 فهو نجاح
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("خطأ في إرسال البلاغ: $e");
      return false;
    }
  }
  
}