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

    List<NewsModel> allData = [];

    // التحقق من أن البيانات ليست نصاً (String) بل خارطة (Map)
    var responseData = responseNews.data;
    if (responseData is Map && responseData.containsKey('data')) {
      List newsList = responseData['data'];
      allData.addAll(newsList.map((j) => NewsModel.fromJson(j)).toList());
    }
    if (responseTips.data is Map && responseTips.data['data'] != null) {
      List tipsList = responseTips.data['data'];
      allData.addAll(tipsList.map((j) => NewsModel.fromJson(j)).toList());
    }

    return allData;
  } catch (e) {
    debugPrint("فشل في جلب البيانات $e");
    return [];
  }
}
}