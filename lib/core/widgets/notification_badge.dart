import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationBadgeProvider extends ChangeNotifier {
  bool _hasUnread = false;
  static const _key = 'has_unread_notification';
  bool get hasUnread => _hasUnread;

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _hasUnread = prefs.getBool(_key) ?? false;
    notifyListeners();
  }

  Future<void> markUnread() async {
    if (!_hasUnread) {
      _hasUnread = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, true);
      notifyListeners();
    }
  }

  Future<void> markRead() async {
    if (_hasUnread) {
      _hasUnread = false;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, false);
      notifyListeners();
    }
  }
}