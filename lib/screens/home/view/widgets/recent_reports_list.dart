import 'package:flutter/material.dart';
import 'package:seiyun_reports_app/core/theme/app_theme.dart';

class RecentReportsList extends StatelessWidget {
  const RecentReportsList({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      {
        "title": "تسرب مياه في شارع الجزائر",
        "date": "2023-11-25",
        "status": "قيد المعالجة",
      },
      {"title": "إنارة عامة متعطلة", "date": "2023-11-24", "status": "جديد"},
      {
        "title": "حاوية ممتلئة - حي الوحدة",
        "date": "2023-11-23",
        "status": "قيد المعالجة",
      },
    ];
    return Column(children: reports.map((r) => _reportItem(r)).toList());
  }

  Widget _reportItem(Map<String, String> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data['title']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "عرض",
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.secondaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, size: 8, color: AppTheme.primaryColor),
                  const SizedBox(width: 5),
                  Text(
                    data['status']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                data['date']!,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
