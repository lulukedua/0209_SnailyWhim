import 'package:flutter/material.dart';
import 'package:snailywhim/core/theme/colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final IconData icon;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: AppColors.primTextColor.withOpacity(.7),
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.primTextColor,
        ),
        filled: true,
        fillColor: AppColors.primColor,
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}