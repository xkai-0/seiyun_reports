import 'package:flutter/material.dart';
import 'package:seiyun_reports_app/screens/news_tips/data/models/news_tips_model.dart';
import '../data/NewsRepository.dart';

class NewsTipsViewModel extends ChangeNotifier {
  final Newsrepository _newsrepository = Newsrepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isNewsSelected = true;
  bool get isNewsSelected => _isNewsSelected;

  //تخزن كل 
  List<NewsModel> _allContent = [];
  List<NewsModel>  get newsList => _allContent.where((item)=>item.type.trim().toLowerCase()=='news').toList();
  List<NewsModel>  get tipssList => _allContent.where((item)=>item.type.trim().toLowerCase()=='tips').toList();


  void toggleSelection(bool isNews) {
    _isNewsSelected = isNews;
    notifyListeners();
  }

  Future <void> fetchDataFromLaravel() async {
    _isLoading = true;
    notifyListeners();
    try{
      _allContent = await _newsrepository.fetchAllContent();
   
    } catch (e) {
     debugPrint("Error fetching content: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }
  }
