import 'package:flutter/material.dart';

class PointsInfo extends StatelessWidget {
  const PointsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFf5f3ff),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFddd6fe)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Color(0xFF7c3aed), size: 26),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "نظام النقاط",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5b21b6),
                  ),
                ),
                Text(
                  "ستحصل على 100 نقطة عند قبول البلاغ، و 250 نقطة إذا تم تصنيفه كحالة طارئة.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6d28d9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
