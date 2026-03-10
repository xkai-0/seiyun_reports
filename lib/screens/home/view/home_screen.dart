import 'package:flutter/material.dart';
import 'package:seiyun_reports_app/core/theme/app_theme.dart';
import 'package:seiyun_reports_app/screens/report/view/report_screen.dart';
import 'package:seiyun_reports_app/screens/home/view/widgets/home_header.dart';
import 'package:seiyun_reports_app/screens/home/view/widgets/stats_cards.dart';
import 'package:seiyun_reports_app/screens/home/view/widgets/next_pickup_card.dart';
import 'package:seiyun_reports_app/screens/home/view/widgets/order_service_banner.dart';
import 'package:seiyun_reports_app/screens/home/view/widgets/section_header.dart';
import 'package:seiyun_reports_app/screens/home/view/widgets/recent_reports_list.dart';
import 'package:seiyun_reports_app/screens/home/view/widgets/news_list.dart';
import 'package:seiyun_reports_app/screens/home/view/widgets/tips_grid.dart';
import 'package:seiyun_reports_app/screens/home/view/widgets/custom_bottom_nav_bar.dart';
import 'package:seiyun_reports_app/screens/map/view/map_screen.dart';
import 'package:seiyun_reports_app/screens/my_reports/view/my_reports_page.dart';
import 'package:seiyun_reports_app/screens/profile/view/profile_screen.dart';

const sectionTitleStyle = TextStyle(
  fontSize: 16,
  color: Color(0xFF0f172a),
  fontWeight: FontWeight.bold,
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _HomeContent(),
    const MapScreen(),
    const MyReportsPage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReportScreen()),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatsCards(),
                  SizedBox(height: 20),
                  NextPickupCard(),
                  SizedBox(height: 20),
                  OrderServiceBanner(),
                  SizedBox(height: 25),
                  SectionHeader(title: "البلاغات الأخيرة", action: "عرض الكل"),
                  SizedBox(height: 15),
                  RecentReportsList(),
                  SizedBox(height: 25),
                  SectionHeader(
                    title: "الأخبار والتحديثات",
                    action: "عرض الكل",
                  ),
                  SizedBox(height: 15),
                  NewsList(),
                  SizedBox(height: 25),
                  Text("نصائح مفيدة", style: sectionTitleStyle),
                  SizedBox(height: 15),
                  TipsGrid(),
                  SizedBox(height: 100), // مساحة للزر العائم
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
