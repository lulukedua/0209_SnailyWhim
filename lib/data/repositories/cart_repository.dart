import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snailywhim/data/models/cart_model.dart';

class CartRepository {
  static const String cartKey = 'cart_items';
  Future<List<CartItemModel>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(cartKey);
    if (data == null) return [];
    final decoded = jsonDecode(data) as List;
    return decoded.map((e) => CartItemModel.fromJson(e)).toList();
  }

  Future<void> saveCart(List<CartItemModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(items.map((e) => e.toJson()).toList());
    await prefs.setString(cartKey, data);
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartKey);
  }

  Future<void> addToCart(CartItemModel item) async {
    final cart = await getCart();
    final index = cart.indexWhere((e) => e.productId == item.productId);
    if (index >= 0) {
      cart[index] = cart[index].copyWith(qty: cart[index].qty + 1);
    } else {
      cart.add(item);
    }
    await saveCart(cart);
  }

  Future<void> removeItem(String productId) async {
    final cart = await getCart();
    cart.removeWhere((e) => e.productId == productId);
    await saveCart(cart);
  }

  Future<void> updateQty({required String productId, required int qty}) async {
    final cart = await getCart();
    final index = cart.indexWhere((e) => e.productId == productId);
    if (index == -1) return;
    cart[index] = cart[index].copyWith(qty: qty);
    await saveCart(cart);
  }
}