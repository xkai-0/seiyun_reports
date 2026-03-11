import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seiyun_reports_app/screens/report/viewmodel/report_viewmodel.dart';
import 'package:seiyun_reports_app/core/theme/app_theme.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  static const List<Map<String, dynamic>> categories = [
    {
      'id': 'نفايات',
      'label': 'نفايات',
      'icon': Icons.delete_outline,
      'color': Color(0xFF27ae60),
      'bg': Color(0xFFe8f5e9),
    },
    {
      'id': 'بناء',
      'label': 'بناء وصيانة',
      'icon': Icons.construction,
      'color': Color(0xFFe67e22),
      'bg': Color(0xFFfff3e0),
    },
    {
      'id': 'إنارة',
      'label': 'إنارة',
      'icon': Icons.lightbulb_outline,
      'color': Color(0xFFf1c40f),
      'bg': Color(0xFFfef9e7),
    },
    {
      'id': 'مياه',
      'label': 'مياه',
      'icon': Icons.opacity,
      'color': Color(0xFF3498db),
      'bg': Color(0xFFebf5fb),
    },
    {
      'id': 'حدائق',
      'label': 'حدائق',
      'icon': Icons.park_outlined,
      'color': Color(0xFF1abc9c),
      'bg': Color(0xFFeafff5),
    },
    {
      'id': 'أخرى',
      'label': 'أخرى',
      'icon': Icons.help_outline,
      'color': Color(0xFF95a5a6),
      'bg': Color(0xFFf4f6f7),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final reportVM = context.watch<ReportViewModel>();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.85,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        bool isSelected = reportVM.selectedCategory == cat['id'];
        return GestureDetector(
          onTap: () => reportVM.setCategory(cat['id']),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isSelected ? AppTheme.accentGreen : Theme.of(context).dividerColor.withOpacity(0.1),
                width: isSelected ? 2.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: (cat['bg'] as Color).withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.2 : 1.0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    cat['icon'] as IconData,
                    color: cat['color'] as Color,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  cat['label'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleSmall?.color,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
