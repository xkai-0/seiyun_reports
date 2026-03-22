import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seiyun_reports_app/screens/report/viewmodel/report_viewmodel.dart';

class PrioritySelector extends StatelessWidget {
  const PrioritySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        _priorityItem(
          context,
          "منخفضة",
          isDark ? const Color(0xFF064e3b) : const Color(0xFFdcfce7),
          isDark ? const Color(0xFF34d399) : const Color(0xFF166534),
        ),
        const SizedBox(width: 10),
        _priorityItem(
          context,
          "متوسطة",
          isDark ? const Color(0xFF78350f) : const Color(0xFFfef9c3),
          isDark ? const Color(0xFFfbbf24) : const Color(0xFF854d0e),
        ),
        const SizedBox(width: 10),
        _priorityItem(
          context,
          "مرتفعة",
          isDark ? const Color(0xFF7f1d1d) : const Color(0xFFfee2e2),
          isDark ? const Color(0xFFf87171) : const Color(0xFF991b1b),
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
