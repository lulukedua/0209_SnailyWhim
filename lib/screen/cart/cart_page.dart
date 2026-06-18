import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snailywhim/core/theme/colors.dart';
import 'package:snailywhim/core/validator/currency.dart';
import 'package:snailywhim/core/widgets/app_snackbar.dart';
import 'package:snailywhim/core/widgets/cart_item_card.dart';
import 'package:snailywhim/core/widgets/custom_button.dart';
import 'package:snailywhim/core/widgets/empty_cart.dart';
import 'package:snailywhim/logic/bloc/cart/cart_bloc.dart';
import 'package:snailywhim/logic/bloc/cart/cart_state.dart';
import 'package:snailywhim/logic/bloc/order/order_bloc.dart';
import 'package:snailywhim/logic/bloc/order/order_state.dart';
import 'package:snailywhim/screen/order/checkout_page.dart';
import 'package:snailywhim/screen/order/order_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderCreatedSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderPage(
                userId: Supabase.instance.client.auth.currentUser!.id,
              ),
            ),
          );
        }

        if (state is OrderError) {
          AppSnackbar.show(
            context,
            title: 'Gagal',
            message: state.message,
            type: SnackType.error,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,

        appBar: AppBar(
          backgroundColor: AppColors.bgBtmColor,
          title: const Text(
            'Keranjang',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CartLoaded) {
              final selectedItems = state.items
                  .where((e) => state.selectedIds.contains(e.productId))
                  .toList();
              final total = selectedItems.fold(
                0,
                (sum, item) => sum + item.subtotal,
              );
              if (state.items.isEmpty) {
                return const EmptyCartView();
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return CartItemCard(
                          item: state.items[index],
                          isSelected: state.selectedIds.contains(
                            state.items[index].productId,
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Total Pembayaran",
                              style: TextStyle(fontSize: 15),
                            ),

                            const Spacer(),

                            Text(
                              CurrencyFormatter.format(total),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.primColor,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        CustomButton(
                          text: "Checkout",
                          onPressed: () {
                            if (selectedItems.isEmpty) {
                              AppSnackbar.show(
                                context,
                                title: 'Perhatian',
                                message: 'Pilih produk terlebih dahulu',
                                type: SnackType.warning,
                              );
                              return;
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<OrderBloc>(),
                                  child: CheckoutPage(
                                    selectedItems: selectedItems,
                                    totalHarga: total,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            if (state is CartError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
