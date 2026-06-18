import 'package:flutter/material.dart';
import 'package:snailywhim/core/theme/colors.dart';
import 'package:snailywhim/core/validator/currency.dart';
import 'package:snailywhim/data/models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;
  final VoidCallback onBeliLagi;
  final String? imageUrl;
  final bool isAdmin;
  final Function(String)? onStatusChanged;

  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
    required this.onBeliLagi,
    this.imageUrl,
    this.isAdmin = false,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final int totalItems = order.item?.length ?? 0;
    final int extraItems = totalItems > 1 ? totalItems - 1 : 0;
    final String productName = (order.item != null && order.item!.isNotEmpty)
        ? (order.item!.first['nama_product'] ??
              'Pesanan #${order.id.substring(0, 8)}')
        : 'Pesanan #${order.id.substring(0, 8)}';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primColor.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.bgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: imageUrl != null && imageUrl!.isNotEmpty
                        ? Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.image_not_supported,
                                  color: AppColors.secondaryTextColor,
                                ),
                          )
                        : const Icon(
                            Icons.fastfood_rounded,
                            color: AppColors.secondaryTextColor,
                            size: 32,
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.primTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      if (extraItems > 0)
                        Text(
                          "+ $extraItems produk lainnya",
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildPaymentBadge(order.status_pembayaran),
                          const SizedBox(width: 8),
                          _buildOrderBadge(order.status_order),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Belanja",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    Text(
                       CurrencyFormatter.format(order.total_harga),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primTextColor,
                      ),
                    ),
                  ],
                ),
                if (!isAdmin)
                  ElevatedButton(
                    onPressed: onBeliLagi,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primColor,
                      foregroundColor: AppColors.primTextColor,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Beli Lagi",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPaymentBadge(String status) {
    bool isPending = status.toLowerCase() == 'pending';
    bool isFailed =
        status.toLowerCase() == 'failed' || status.toLowerCase() == 'expired';
    Color textColor = isPending
        ? AppColors.warningTextColor
        : (isFailed ? Colors.red : AppColors.bgBtmColor);
    Color bgColor = textColor.withOpacity(0.15);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
  Widget _buildOrderBadge(String status) {
    String safeStatus = status.toLowerCase();
    Color textColor;
    Color bgColor;
    if (safeStatus == 'waiting') {
      textColor = Colors.orange[800]!;
      bgColor = Colors.orange[100]!;
    } else if (safeStatus == 'selesai') {
      textColor = AppColors.bgBtmColor;
      bgColor = AppColors.bgBtmColor.withOpacity(0.15);
    } else {
      textColor = Colors.blue[700]!;
      bgColor = Colors.blue[100]!;
    }
    if (isAdmin) {
      final validStatuses = ['waiting', 'process', 'selesai'];
      final currentStatus = validStatuses.contains(safeStatus)
          ? safeStatus
          : 'waiting';
      return Container(
        height: 24, // Dibuat seukuran badge biasa
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: textColor.withOpacity(0.3)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: currentStatus,
            icon: Icon(Icons.arrow_drop_down, color: textColor, size: 16),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            items: validStatuses.map((s) {
              return DropdownMenuItem(value: s, child: Text(s.toUpperCase()));
            }).toList(),
            onChanged: (val) {
              if (val != null &&
                  val != currentStatus &&
                  onStatusChanged != null) {
                onStatusChanged!(val);
              }
            },
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}