import 'package:flutter/material.dart';
import 'package:snailywhim/core/theme/colors.dart';
import 'package:snailywhim/core/validator/currency.dart';
import 'package:snailywhim/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback onTap;
  final bool showMenu;
  final VoidCallback? onAddToCart;
  final bool isAdmin;

  const ProductCard({
    super.key,
    required this.product,
    this.onEdit,
    this.onDelete,
    required this.onTap,
    this.showMenu = true,
    this.onAddToCart,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: (product.image_url != null && product.image_url!.isNotEmpty)
                      ? Image.network(
                          product.image_url!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildPlaceholder();
                          },
                        )
                      : _buildPlaceholder(),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  color: Colors.white, 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, 
                    children: [
                      Text(
                        product.nama_product,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500, 
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        CurrencyFormatter.format(product.harga),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold, 
                          color: AppColors.primColor, 
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.stok == 0 ? "Stok Habis" : "Sisa stok: ${product.stok}",
                        style: TextStyle(
                          fontSize: 11,
                          color: product.stok == 0 ? Colors.red : Colors.grey.shade600,
                        ),
                      ),
                      if (!isAdmin) ...[
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 32, 
                          child: ElevatedButton.icon(
                            onPressed: onAddToCart,
                            icon: const Icon(Icons.add_shopping_cart, size: 16),
                            label: const Text("Tambah", style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.zero, 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ] else ...[
                         const SizedBox(height: 4),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (showMenu)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: PopupMenuButton<String>(
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    onSelected: (value) {
                      if (value == 'edit') onEdit?.call();
                      if (value == 'hapus') onDelete?.call();
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit')),
                      const PopupMenuItem(value: 'hapus', child: Text('Hapus')),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade100,
      child: const Center(
        child: Icon(Icons.image_outlined, size: 40, color: Colors.grey),
      ),
    );
  }
}