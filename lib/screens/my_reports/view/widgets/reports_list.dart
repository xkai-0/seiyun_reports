import 'package:flutter/material.dart';
import 'package:seiyun_reports_app/screens/my_reports/data/models/report_model.dart';
import 'package:seiyun_reports_app/screens/my_reports/view/widgets/report_card.dart';

class ReportsList extends StatelessWidget {
  final List<ReportModel> reports;

  const ReportsList({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return ReportCard(report: reports[index]);
      },
    );
  }
}
