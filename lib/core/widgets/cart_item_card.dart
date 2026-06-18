import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snailywhim/core/theme/colors.dart';
import 'package:snailywhim/core/validator/currency.dart';
import 'package:snailywhim/data/models/cart_model.dart';
import 'package:snailywhim/logic/bloc/cart/cart_bloc.dart';
import 'package:snailywhim/logic/bloc/cart/cart_event.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final bool isSelected;
  const CartItemCard({super.key, required this.item, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (_) {
              context.read<CartBloc>().add(ToggleCartItem(item.productId));
            },
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                ? Image.network(
                    item.imageUrl!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_outlined, color: Colors.grey),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.namaProduct,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  CurrencyFormatter.format(item.harga),
                  style: const TextStyle(
                    color: AppColors.primColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Subtotal: ${CurrencyFormatter.format(item.subtotal)}",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<CartBloc>().add(DecreaseQty(item.productId));
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text(
                    item.qty.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<CartBloc>().add(IncreaseQty(item.productId));
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {context.read<CartBloc>().add(RemoveFromCart(item.productId));},
                icon: const Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.red,
                ),
                label: const Text("Hapus", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}