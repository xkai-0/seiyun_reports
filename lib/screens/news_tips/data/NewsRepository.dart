import 'package:flutter/foundation.dart';
import 'package:seiyun_reports_app/core/network/dio_client.dart';
import 'package:seiyun_reports_app/core/network/api_service.dart';
import 'NewsService.dart';
import 'models/news_tips_model.dart';

class Newsrepository {
  late Newsservice _newsService ;

  Newsrepository(){
    final dioClient = DioClient();
    final apiService = ApiService(dioClient);
    _newsService = Newsservice(apiService);
    
  }
  Future<List<NewsModel>> fetchAllContent() async {
    try {
      // جلب الاخبار وجلب النصايح
      final responseNews = await _newsService.getNews();
      final responseTips = await _newsService.getTips();

      // استخدام compute لتشغيل عملية التحليل في Isolate منفصل لتجنب تعليق الواجهة
      return await compute(_parseAllContent, {
        'news': responseNews.data,
        'tips': responseTips.data,
      });
    } catch (e) {
      debugPrint("فشل في جلب البيانات $e");
      return [];
    }
  }

  // دالة ثابتة ليتم تشغيلها داخل compute
  static List<NewsModel> _parseAllContent(Map<String, dynamic> data) {
    List<NewsModel> allData = [];

    // تحليل الأخبار
    var responseNewsData = data['news'];
    if (responseNewsData is Map && responseNewsData.containsKey('data')) {
      List newsList = responseNewsData['data'];
      allData.addAll(newsList.map((j) => NewsModel.fromJson(j)).toList());
    }

    // تحليل النصائح
    var responseTipsData = data['tips'];
    if (responseTipsData is Map && responseTipsData.containsKey('data')) {
      List tipsList = responseTipsData['data'];
      allData.addAll(tipsList.map((j) => NewsModel.fromJson(j)).toList());
    }

    return allData;
  }
}