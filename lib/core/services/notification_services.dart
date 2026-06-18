import 'dart:developer' as developer;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:snailywhim/core/widgets/notification_badge.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  RealtimeChannel? _channel;
  NotificationBadgeProvider? _badgeProvider;

  Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    final InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(initSettings);
  }

  void startListening({
    required String userId,
    required NotificationBadgeProvider badgeProvider,
  }) {
    _badgeProvider = badgeProvider;
    developer.log('START LISTENING for userId: $userId', name: 'NotificationService');
    _channel = Supabase.instance.client
        .channel('order-status-$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'order',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            developer.log('🔔 REALTIME EVENT RECEIVED: ${payload.newRecord}', name: 'NotificationService');
            developer.log(
              'Order updated: ${payload.newRecord}',
              name: 'NotificationService',
            );

            final newStatus = payload.newRecord['status_order'] as String?;
            final orderId = payload.newRecord['id'] as String?;

            _badgeProvider?.markUnread();
            _showLocalNotification(
              title: 'Update Status Pesanan',
              body: _statusMessage(newStatus),
              id: orderId.hashCode,
            );
          },
        )
        .subscribe((status, error){
          developer.log('CHANNEL STATUS: $status, error: $error', name: 'NotificationService');
        });
  }

  void stopListening() {
    _channel?.unsubscribe();
    _channel = null;
  }

  String _statusMessage(String? status) {
    switch (status?.toLowerCase()) {
      case 'process':
        return 'Pesananmu sedang diproses oleh admin.';
      case 'done':
        return 'Pesananmu sudah selesai! Silakan ambil.';
      case 'cancelled':
        return 'Pesananmu telah dibatalkan.';
      case 'waiting':
        return 'Pesananmu menunggu konfirmasi admin.';
      default:
        return 'Status pesananmu telah diperbarui.';
    }
  }

  Future<void> _showLocalNotification({
    required String title,
    required String body,
    required int id,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'order_status_channel',
          'Status Pesanan',
          channelDescription: 'Notifikasi perubahan status order',
          importance: Importance.high,
          priority: Priority.high,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(id, title, body, details);
  }
}
