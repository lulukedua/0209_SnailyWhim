import 'package:flutter/material.dart';
import 'package:snailywhim/core/theme/colors.dart';
import 'package:snailywhim/core/validator/currency.dart';

class DetailInfoCard extends StatelessWidget {
  final String namaProduk;
  final int harga;

  const DetailInfoCard({
    super.key,
    required this.namaProduk,
    required this.harga,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          namaProduk,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.primTextColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          CurrencyFormatter.format(harga),
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.primTextColor,
          ),
        ),
      ],
    );
  }
}