import 'package:flutter/material.dart';
import 'package:snailywhim/core/theme/colors.dart';

class InfoCardItem {
  final IconData icon;
  final String label;
  final String value;

  const InfoCardItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}

class InfoCard extends StatelessWidget {
  final List<InfoCardItem> items;
  const InfoCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.bgBtmColor,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(item.icon, color: AppColors.primColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label,
                          style: TextStyle(
                            color: AppColors.bgBtmColor,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primTextColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (index != items.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),

                  child: Divider(),
                ),
            ],
          );
        }),
      ),
    );
  }
}