import 'package:flutter/material.dart';
import 'package:snailywhim/core/theme/colors.dart';
import 'package:snailywhim/core/validator/currency.dart';
import 'package:snailywhim/data/models/order_model.dart';

class RecentOrderCard extends StatelessWidget {
  final OrderModel order;
  final String? imageUrl;

  const RecentOrderCard({super.key, required this.order, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    Color badgeTextColor;
    String badgeLabel;

    final safeStatus = order.status_order.toLowerCase();
    if (safeStatus == 'waiting') {
      badgeColor = Colors.orange[100]!;
      badgeTextColor = Colors.orange[800]!;
      badgeLabel = "WAITING";
    } else if (safeStatus == 'selesai') {
      badgeColor = AppColors.bgBtmColor.withOpacity(0.15);
      badgeTextColor = AppColors.bgBtmColor;
      badgeLabel = "SELESAI";
    } else {
      badgeColor = Colors.blue[100]!;
      badgeTextColor = Colors.blue[700]!;
      badgeLabel = "PROCESS";
    }

    final String productName = (order.item != null && order.item!.isNotEmpty)
        ? (order.item!.first['nama_product'] ??
              'Pesanan #${order.id.substring(0, 8)}')
        : 'Pesanan #${order.id.substring(0, 8)}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "Order #${order.id.substring(0, 8)}",
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                CurrencyFormatter.format(order.total_harga),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  badgeLabel,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: badgeTextColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
