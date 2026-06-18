import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snailywhim/core/theme/colors.dart';
import 'package:snailywhim/data/repositories/order_repository.dart';
import 'package:snailywhim/data/repositories/product_repository.dart';
import 'package:snailywhim/logic/bloc/cart/cart_bloc.dart';
import 'package:snailywhim/logic/bloc/cart/cart_state.dart';
import 'package:snailywhim/logic/bloc/order/order_bloc.dart';
import 'package:snailywhim/screen/cart/cart_page.dart';

class CartBadgeButton extends StatelessWidget {
  final Color iconColor;
  final double iconSize;

  const CartBadgeButton({
    super.key,
    this.iconColor = AppColors.primColor,
    this.iconSize = 26,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        int totalItems = 0;
        if (state is CartLoaded) {
          totalItems = state.items.fold(0, (sum, item) => sum + item.qty);
        }
        return Badge(
          isLabelVisible: totalItems > 0,
          backgroundColor: AppColors.primTextColor,
          largeSize: 22,
          offset: const Offset(4, -4),
          padding: const EdgeInsets.symmetric(horizontal: 7),
          label: Text(
            totalItems > 99 ? '99+' : totalItems.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: iconColor,
              size: iconSize,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: context.read<CartBloc>()),

                      BlocProvider(
                        create: (_) => OrderBloc(
                          repository: OrderRepository(),
                          productRepository: ProductRepository(),
                        ),
                      ),
                    ],
                    child: const CartPage(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}