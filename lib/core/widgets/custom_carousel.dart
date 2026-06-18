import 'package:flutter/material.dart';

class HomeBannerCarousel extends StatelessWidget {
  const HomeBannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                "Banner ${index + 1}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }
}