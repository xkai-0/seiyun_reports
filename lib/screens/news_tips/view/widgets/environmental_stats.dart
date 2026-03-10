import 'package:flutter/material.dart';

class EnvironmentalStats extends StatelessWidget {
  const EnvironmentalStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "إنجازاتنا البيئية",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            _statBox(
              "12,500",
              "أطنان تم تدويرها",
              Icons.rebase_edit,
              Colors.green,
            ),
            const SizedBox(width: 10),
            _statBox(
              "3,200",
              "أشجار تم زراعتها",
              Icons.park_outlined,
              Colors.teal,
            ),
            const SizedBox(width: 10),
            _statBox("850K", "لتر ماء تم توفيره", Icons.opacity, Colors.blue),
          ],
        ),
      ],
    );
  }

  Widget _statBox(String val, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              val,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
