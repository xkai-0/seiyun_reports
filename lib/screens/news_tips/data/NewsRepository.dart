import 'package:flutter/foundation.dart';
import 'package:seiyun_reports_app/core/network/dio_client.dart';
import 'package:seiyun_reports_app/core/network/api_service.dart';
import 'NewsService.dart';
import 'news_tips_model.dart';

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

    List<NewsModel> allData = [];

// معالجة الأخبار
    if (responseNews.statusCode == 200 && responseNews.data['status'] == 'success') {
      List newsList = responseNews.data['data'];
      allData.addAll(newsList.map((j) => NewsModel.fromJson(j)).toList());
    }

    // معالجة النصائح
    if (responseTips.statusCode == 200 && responseTips.data['status'] == 'success') {
      List tipsList = responseTips.data['data'];
      allData.addAll(tipsList.map((j) => NewsModel.fromJson(j)).toList());
    }

    allData.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return allData;
  } catch (e) {
    debugPrint("فشل في جلب البيانات $e");
    return [];
  }
}
}