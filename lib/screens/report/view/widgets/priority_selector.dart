import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seiyun_reports_app/screens/report/viewmodel/report_viewmodel.dart';

class PrioritySelector extends StatelessWidget {
  const PrioritySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _priorityItem(
          context,
          "منخفضة",
          const Color(0xFFdcfce7),
          const Color(0xFF166534),
        ),
        const SizedBox(width: 10),
        _priorityItem(
          context,
          "متوسطة",
          const Color(0xFFfef9c3),
          const Color(0xFF854d0e),
        ),
        const SizedBox(width: 10),
        _priorityItem(
          context,
          "مرتفعة",
          const Color(0xFFfee2e2),
          const Color(0xFF991b1b),
        ),
      ],
    );
  }

  Widget _priorityItem(
    BuildContext context,
    String label,
    Color bg,
    Color text,
  ) {
    final reportVM = context.watch<ReportViewModel>();
    bool isActive = reportVM.selectedPriority == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => reportVM.setPriority(label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isActive ? text : Colors.transparent,
              width: 2.5,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: text,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
