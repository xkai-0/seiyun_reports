import 'package:flutter/material.dart';

class TipsGrid extends StatelessWidget {
  const TipsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tipCard("كيف تقدم بلاغاً فعالاً؟", Icons.lightbulb_outline),
        const SizedBox(width: 15),
        _tipCard("أوقات الاستجابة المتوقعة", Icons.access_time),
      ],
    );
  }

  Widget _tipCard(String title, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBEB),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.orange, size: 28),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
