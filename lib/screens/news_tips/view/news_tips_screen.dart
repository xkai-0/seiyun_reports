import 'package:flutter/material.dart';
import 'package:seiyun_reports_app/screens/news_tips/data/models/news_model.dart';
import 'package:seiyun_reports_app/screens/news_tips/data/models/tip_model.dart';
import 'package:seiyun_reports_app/screens/news_tips/view/widgets/news_tips_header.dart';
import 'package:seiyun_reports_app/screens/news_tips/view/widgets/environmental_stats.dart';
import 'package:seiyun_reports_app/screens/news_tips/view/widgets/news_section_header.dart';
import 'package:seiyun_reports_app/screens/news_tips/view/widgets/news_card.dart';
import 'package:seiyun_reports_app/screens/news_tips/view/widgets/tip_item.dart';
import 'package:seiyun_reports_app/screens/news_tips/view/widgets/call_to_action_card.dart';

class NewsTipsScreen extends StatefulWidget {
  const NewsTipsScreen({super.key});

  @override
  State<NewsTipsScreen> createState() => _NewsTipsScreenState();
}

class _NewsTipsScreenState extends State<NewsTipsScreen> {
  bool isNewsSelected = true;

  // هذه القوائم ستكون فارغة في البداية وتُعبأ بعد جلب البيانات من الـ API
  final List<NewsModel> newsList = [
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

  final List<TipModel> tipsList = [
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

  @override
  void initState() {
    super.initState();
    // Fetch data when the screen initializes
    _fetchData();
  }

  void _fetchData() {
    // هنا يتم استدعاء دالة جلب البيانات من Laravel مستقبلاً
  }

  void _toggleSelection(bool isNews) {
    setState(() {
      isNewsSelected = isNews;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              NewsTipsHeader(
                isNewsSelected: isNewsSelected,
                onToggle: _toggleSelection,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EnvironmentalStats(),
                    const SizedBox(height: 25),
                    if (isNewsSelected) ...[
                      const NewsSectionHeader(title: "أهم الأخبار"),
                      ...newsList.map((news) => NewsCard(news: news)),
                    ] else ...[
                      const NewsSectionHeader(title: "نصائح بيئية"),
                      ...tipsList.map((tip) => TipItem(tip: tip)),
                    ],
                    const SizedBox(height: 25),
                    const CallToActionCard(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
