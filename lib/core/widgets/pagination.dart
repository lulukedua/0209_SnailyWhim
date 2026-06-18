import 'package:flutter/material.dart';
import 'package:snailywhim/core/theme/colors.dart';

class PaginationControl extends StatelessWidget {
  final int currentPage;
  final int totalPage;
  final ValueChanged<int> onPageSelected;

  const PaginationControl({
    super.key,
    required this.currentPage,
    required this.totalPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPage <= 1) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPage, (index) {
          final bool isActive = index + 1 == currentPage;

          return GestureDetector(
            onTap: () => onPageSelected(index + 1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 28 : 10,
              height: 10,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.bgBtmColor
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        }),
      ),
    );
  }
}