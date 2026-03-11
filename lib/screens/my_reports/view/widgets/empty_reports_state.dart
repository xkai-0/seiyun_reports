import 'package:flutter/material.dart';
import 'package:seiyun_reports_app/core/theme/app_theme.dart';

class EmptyReportsState extends StatelessWidget {
  const EmptyReportsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.description_outlined,
              size: 80,
              color: Colors.grey.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "لا توجد بلاغات حالياً",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "لم تقم بإرسال أي بلاغ بعد.\nيمكنك البدء بالمساهمة في نظافة مدينتك الآن.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color:
                    Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
