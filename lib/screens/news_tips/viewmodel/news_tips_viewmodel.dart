import 'package:flutter/material.dart';
import 'package:seiyun_reports_app/screens/news_tips/data/models/news_model.dart';
import 'package:seiyun_reports_app/screens/news_tips/data/models/tip_model.dart';

class NewsTipsViewModel extends ChangeNotifier {
  bool _isNewsSelected = true;
  bool get isNewsSelected => _isNewsSelected;

  void toggleSelection(bool isNews) {
    _isNewsSelected = isNews;
    notifyListeners();
  }

  // هذه القوائم ستكون فارغة في البداية وتُعبأ بعد جلب البيانات من الـ API
  List<NewsModel> newsList = [
    NewsModel(
      tag: "مبادرات",
      title: "إطلاق برنامج 'المدينة الخضراء 2025'",
      desc:
          "البلدية تعلن عن مبادرة جديدة لزيادة المساحات الخضراء وتحسين جودة الهواء.",
      time: "3 دقائق",
      date: "2025/11/28",
    ),
    NewsModel(
      tag: "إنجازات",
      title: "نجاح تجربة الفصل من المصدر في 5 أحياء",
      desc: "ارتفاع نسبة إعادة التدوير بنسبة 40% في الأحياء التجريبية.",
      time: "5 دقائق",
      date: "2025/11/26",
    ),
  ];

  List<TipModel> tipsList = [
    TipModel(
      title: "كيفية فصل النفايات بشكل صحيح",
      desc:
          "افصل البلاستيك والورق والمعادن عن النفايات العضوية لتسهيل إعادة التدوير.",
      icon: Icons.recycling,
      color: Colors.green,
    ),
    TipModel(
      title: "استخدام الأكياس القابلة لإعادة الاستخدام",
      desc: "استبدل الأكياس البلاستيكية بأكياس قماشية قابلة للاستخدام المتكرر.",
      icon: Icons.shopping_bag_outlined,
      color: Colors.teal,
    ),
    TipModel(
      title: "تقليل استهلاك المياه",
      desc: "استخدم المياه الرمادية لري النباتات وتنظيف الممرات الخارجية.",
      icon: Icons.water_drop_outlined,
      color: Colors.blue,
    ),
  ];

  void fetchDataFromLaravel() {
    // هنا يتم استدعاء دالة جلب البيانات من Laravel مستقبلاً
    // notifyListeners() بعد الانتهاء
  }
}
