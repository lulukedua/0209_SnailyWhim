import 'package:flutter/material.dart';

class CustomNetworkBanner extends StatelessWidget {
  final String? imageUrl;
  final double height;
  const CustomNetworkBanner({
    super.key,
    required this.imageUrl,
    this.height = 320,
  });
  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.shade200,
        child: const Center(
          child: Icon(Icons.image, size: 100),
        ),
      );
    }
    return SizedBox.expand(
      child: Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            color: Colors.grey.shade200,
            child: const Center(
              child: Icon(Icons.broken_image, size: 100),
            ),
          );
        },
      ),
    );
  }
}