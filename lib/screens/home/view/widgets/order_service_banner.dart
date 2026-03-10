import 'package:flutter/material.dart';

class OrderServiceBanner extends StatelessWidget {
  const OrderServiceBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF27ae60), Color(0xFF2c3e50)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(Icons.add_circle_outline, color: Colors.white, size: 28),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "اطلب الآن",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  "الخدمات التي تحتاجها",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.print_outlined, color: Colors.white, size: 30),
        ],
      ),
    );
  }
}
