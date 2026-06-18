import 'dart:developer' as developer;
import 'package:snailywhim/core/services/supabase_services.dart';
import 'package:snailywhim/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRepository {
  final SupabaseClient _supabase = SupabaseServices.client;

  Future<List<OrderModel>> getAllOrders({
    required int page,
    int limit = 10,
  }) async {
    final int limit = 10;
    final int from = (page - 1) * limit;
    final int to = from + limit - 1;
    try {
      final response = await _supabase
          .from('order')
          .select()
          .order('created_at', ascending: false)
          .range(from, to);
      return response
          .map<OrderModel>((json) => OrderModel.fromJson(json))
          .toList();
    } catch (e) {
      developer.log('Gagal mengambil order', error: e, name: 'OrderRepository');
      throw 'Gagal mengambil order';
    }
  }

  Future<List<OrderModel>> getOrdersByUser({
    required String userId,
    required int page,
    // int limit = 10,
  }) async {
    final int limit = 10;
    final int from = (page - 1) * limit;
    final int to = from + limit - 1;
    try {
      // final from = (page - 1) * limit;
      // final to = from + limit - 1;
      final response = await _supabase
          .from('order')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .range(from, to);
      return response
          .map<OrderModel>((json) => OrderModel.fromJson(json))
          .toList();
    } catch (e) {
      throw 'Gagal mengambil riwayat pesanan';
    }
  }

  Future<OrderModel> getOrderById(String id) async {
    try {
      final response = await _supabase
          .from('order')
          .select()
          .eq('id', id)
          .single();
      return OrderModel.fromJson(response);
    } catch (e) {
      throw 'Pesanan tidak ditemukan';
    }
  }

  Future<Map<String, dynamic>> createOrder({
    required List<Map<String, dynamic>> items,
    required int totalHarga,
    required String userId,
  }) async {
    final response = await SupabaseServices.client.functions.invoke(
      'create-order',
      body: {'user_id': userId, 'items': items, 'total_harga': totalHarga},
    );

    return response.data;
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String statusOrder,
  }) async {
    try {
      await _supabase
          .from('order')
          .update({
            'status_order': statusOrder,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId);
    } catch (e) {
      throw 'Gagal mengubah status pesanan';
    }
  }

  Future<void> updatePaymentStatus({
    required String orderId,
    required String paymentStatus,
    String? paymentType,
  }) async {
    try {
      await _supabase
          .from('order')
          .update({
            'status_pembayaran': paymentStatus,
            'payment_type': paymentType,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId);
    } catch (e) {
      throw 'Gagal mengubah status pembayaran';
    }
  }

  Future<List<dynamic>> getOrderItems(String orderId) async {
    final result = await _supabase
        .from('order')
        .select('item')
        .eq('id', orderId)
        .single();
    return result['item'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> getProfile() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    return await Supabase.instance.client
        .from('profile')
        .select()
        .eq('id', userId)
        .single();
  }

  Future<void> deleteOrder(String orderId) async {
    await _supabase.from('order').delete().eq('id', orderId);
  }

  Future<void> saveMidtransData({
    required String orderId,
    required String snapToken,
    required String midtransOrderId,
  }) async {
    await _supabase
        .from('order')
        .update({'snap_token': snapToken, 'midtrans_order_id': midtransOrderId})
        .eq('id', orderId);
  }

  Future<List<OrderModel>> getNotificationOrders({
    required String userId,
    required int page,
    // int limit = 10,
  }) async {
    // final from = (page - 1) * limit;
    // final to = from + limit - 1;
    final int limit = 10;
    final int from = (page - 1) * limit;
    final int to = from + limit - 1;

    final response = await _supabase
        .from('order')
        .select()
        .eq('user_id', userId)
        .neq('status_order', 'waiting')
        .order('updated_at', ascending: false)
        .range(from, to);

    return response.map<OrderModel>((e) => OrderModel.fromJson(e)).toList();
  }

  Future<int> countAllOrders() async {
    final response = await _supabase
        .from('order')
        .select()
        .count(CountOption.exact);
    return response.count;
  }
  Future<int> countOrdersByStatus(String status) async {
    final response = await _supabase
        .from('order')
        .select()
        .eq('status_order', status)
        .count(CountOption.exact);
    return response.count;
  }
  Future<int> getTotalRevenue() async {
    final response = await _supabase
        .from('order')
        .select('total_harga')
        .eq('status_pembayaran', 'paid');
    return response.fold<int>(0, (sum, row) {
      final val = row['total_harga'];
      if (val == null) return sum;
      return sum + (val is int ? val : int.tryParse(val.toString()) ?? 0);
    });
  }
}
