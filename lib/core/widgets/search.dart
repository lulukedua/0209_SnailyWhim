import 'package:flutter/material.dart';
import 'package:snailywhim/core/theme/colors.dart';

class SearchInput extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const SearchInput({
    super.key,
    required this.hintText,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        color: AppColors.primTextColor,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.primTextColor.withOpacity(.6),
          fontSize: 14,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.primColor,
          size: 20,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}