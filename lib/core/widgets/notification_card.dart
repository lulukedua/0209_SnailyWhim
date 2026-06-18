import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snailywhim/data/models/order_model.dart';

class NotificationCard extends StatelessWidget {
  final OrderModel order;

  const NotificationCard({
    super.key,
    required this.order,
  });

  String getNotificationTitle(String status) {
    switch (status) {
      case "process":
        return "Pesanan Sedang Diproses";
      case "selesai":
        return "Pesanan Siap Diambil";
      default:
        return "";
    }
  }

  String getNotificationMessage(String status) {
    switch (status) {
      case "process":
        return "Admin sedang menyiapkan pesananmu.";
      case "selesai":
        return "Pesananmu sudah selesai dan siap diambil.";
      default:
        return "";
    }
  }

  IconData getNotificationIcon(String status) {
    switch (status) {
      case "process":
        return Icons.local_shipping_outlined;

      case "selesai":
        return Icons.check_circle_outline;

      default:
        return Icons.notifications_none;
    }
  }

  Color getNotificationColor(String status) {
    switch (status) {
      case "process":
        return Colors.orange;

      case "selesai":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: getNotificationColor(
            order.status_order,
          ).withValues(alpha: 0.15),
          child: Icon(
            getNotificationIcon(order.status_order),
            color: getNotificationColor(order.status_order),
          ),
        ),

        title: Text(
          getNotificationTitle(order.status_order),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            getNotificationMessage(order.status_order),
          ),
        ),

        trailing: Text(
          DateFormat("dd MMM").format(order.updated_at!),
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}