import 'dart:io';
import 'package:flutter/material.dart';

class CustomImagePicker extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;
  final VoidCallback onTap;

  final String title;
  final bool isCircle;
  final double? size;
  final bool isLoading;

  const CustomImagePicker({
    super.key,
    required this.onTap,
    this.imageFile,
    this.imageUrl,
    this.title = "Pilih Gambar",
    this.isCircle = false,
    this.size,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (isLoading) {
      child = const Center(child: CircularProgressIndicator());
    } else if (imageFile != null) {
      child = isCircle
          ? ClipOval(
              child: Image.file(
                imageFile!,
                fit: BoxFit.cover,
                width: size,
                height: size,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(imageFile!, fit: BoxFit.cover),
            );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      child = isCircle
          ? ClipOval(
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                width: size,
                height: size,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl!, fit: BoxFit.cover),
            );
    } else {
      child = Center(
        child: isCircle
            ? const Icon(Icons.person, size: 40, color: Colors.grey)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.image, size: 40),
                  const SizedBox(height: 12),
                  Text(title),
                ],
              ),
      );
    }
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: isCircle ? size : 180,
            width: isCircle ? size : double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(
                color: Colors.grey.shade300,
                width: isCircle ? 2 : 1,
              ),
              borderRadius: isCircle ? null : BorderRadius.circular(12),
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            ),
            child: child,
          ),
          if (isCircle && !isLoading)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 14,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}