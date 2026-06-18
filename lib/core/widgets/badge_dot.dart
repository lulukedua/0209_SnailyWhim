import 'package:flutter/material.dart';
import 'package:snailywhim/core/theme/colors.dart';

class BadgeDot extends StatelessWidget {
  final Widget child;
  final bool show;

  const BadgeDot({super.key, required this.child, required this.show});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (show)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primTextColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
