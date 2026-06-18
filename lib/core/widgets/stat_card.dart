import 'package:flutter/material.dart';
import 'package:snailywhim/core/theme/colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color mainColor;
  final Color bgColor;

  const StatCard({
    super.key, required this.title, required this.value, required this.subtitle,
    required this.icon, required this.mainColor, required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primColor.withOpacity(0.4), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: mainColor),
              const SizedBox(width: 6),
              Text(title, style: const TextStyle(fontSize: 10, color: AppColors.secondaryTextColor, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primTextColor), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(99)),
            child: Text(subtitle, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: mainColor)),
          ),
        ],
      ),
    );
  }
}