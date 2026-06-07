import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'firestore_service.dart'; // NEW: Imported Firebase service

class CurrencyManager {
  static const String _kCoinsKey = 'user_wallet_coins';
  static const String _kPointsKey = 'user_wallet_points';
  static const String _kInv5050 = 'inv_5050';
  static const String _kInvTime = 'inv_time';
  static const String _kActiveTheme = 'active_theme';
  static const String _kSpecialBundleCount = 'special_bundle_count';
  static const String _kLastSeenTime = 'security_last_seen_time';

  // NEW: Account-specific data key (Prefix) generator
  static String _getPrefix() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null ? '${user.uid}_' : 'guest_';
  }

  // --- THEMES ---
  static Future<String> getActiveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('${_getPrefix()}$_kActiveTheme') ?? 'default';
  }

  // CHANGED: Since theme changed, save to cloud
  static Future<void> setActiveTheme(String themeKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${_getPrefix()}$_kActiveTheme', themeKey);

    FirestoreService().saveUserDataToCloud(); // <-- ADDED
  }

  // --- READ OPERATIONS (We don’t touch read operations) ---
  static Future<int> getCoins() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('${_getPrefix()}$_kCoinsKey') ?? 0;
  }

  static Future<int> getPoints() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('${_getPrefix()}$_kPointsKey') ?? 0;
  }

  static Future<int> getInventory(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    if (itemId == 'hint_5050') return prefs.getInt('${_getPrefix()}$_kInv5050') ?? 0;
    if (itemId == 'theme_gold' || itemId == 'theme_diamond') {
      return prefs.getInt('${_getPrefix()}$itemId') ?? 0;
    }
    if (itemId == 'time_freeze') return prefs.getInt('${_getPrefix()}$_kInvTime') ?? 0;
    return 0;
  }

  // --- WRITE / INVENTORY OPERATIONS ---
  static Future<void> addItem(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    if (itemId == 'hint_5050') {
      int current = prefs.getInt('${_getPrefix()}$_kInv5050') ?? 0;
      await prefs.setInt('${_getPrefix()}$_kInv5050', current + 1);
    } else if (itemId == 'time_freeze') {
      int current = prefs.getInt('${_getPrefix()}$_kInvTime') ?? 0;
      await prefs.setInt('${_getPrefix()}$_kInvTime', current + 1);
    } else if (itemId == 'theme_gold' || itemId == 'theme_diamond') {
      await prefs.setInt('${_getPrefix()}$itemId', 1);
    }

    FirestoreService().saveUserDataToCloud(); // <-- ADDED
  }

  static Future<void> useItem(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    if (itemId == 'hint_5050') {
      int current = prefs.getInt('${_getPrefix()}$_kInv5050') ?? 0;
      if (current > 0) await prefs.setInt('${_getPrefix()}$_kInv5050', current - 1);
    } else if (itemId == 'time_freeze') {
      int current = prefs.getInt('${_getPrefix()}$_kInvTime') ?? 0;
      if (current > 0) await prefs.setInt('${_getPrefix()}$_kInvTime', current - 1);
    }

    FirestoreService().saveUserDataToCloud(); // <-- ADDED
  }

  static Future<void> addPoints(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    int current = prefs.getInt('${_getPrefix()}$_kPointsKey') ?? 0;
    await prefs.setInt('${_getPrefix()}$_kPointsKey', current + amount);

    FirestoreService().saveUserDataToCloud(); // <-- ADDED
  }

  static Future<void> addCoins(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    int current = prefs.getInt('${_getPrefix()}$_kCoinsKey') ?? 0;
    await prefs.setInt('${_getPrefix()}$_kCoinsKey', current + amount);

    FirestoreService().saveUserDataToCloud(); // <-- ADDED
  }

  static Future<bool> spendCoins(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    int current = prefs.getInt('${_getPrefix()}$_kCoinsKey') ?? 0;
    if (current >= amount) {
      await prefs.setInt('${_getPrefix()}$_kCoinsKey', current - amount);

      FirestoreService().saveUserDataToCloud(); // <-- ONLY ADDED IF SUCCESSFUL
      return true;
    }
    return false;
  }

  static Future<bool> convertPointsToCoins(int pointsToSpend, int coinsToGet) async {
    final prefs = await SharedPreferences.getInstance();
    int currentPoints = prefs.getInt('${_getPrefix()}$_kPointsKey') ?? 0;
    int currentCoins = prefs.getInt('${_getPrefix()}$_kCoinsKey') ?? 0;

    if (currentPoints >= pointsToSpend) {
      await prefs.setInt('${_getPrefix()}$_kPointsKey', currentPoints - pointsToSpend);
      await prefs.setInt('${_getPrefix()}$_kCoinsKey', currentCoins + coinsToGet);

      FirestoreService().saveUserDataToCloud(); // <-- ONLY ADDED IF SUCCESSFUL
      return true;
    }
    return false;
  }

  // --- SPECIAL OFFER ---
  static Future<int> getSpecialBundleCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('${_getPrefix()}$_kSpecialBundleCount') ?? 0;
  }

  static Future<void> incrementSpecialBundleCount() async {
    final prefs = await SharedPreferences.getInstance();
    final int current = prefs.getInt('${_getPrefix()}$_kSpecialBundleCount') ?? 0;
    await prefs.setInt('${_getPrefix()}$_kSpecialBundleCount', current + 1);

    FirestoreService().saveUserDataToCloud(); // <-- ADDED
  }

  // --- CHEAT PROTECTION (Device-based only) ---
  // Cheat protection doesn’t need to go to cloud, it’s device-specific
  static Future<bool> isDateManipulated() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    int? lastSeenMillis = prefs.getInt(_kLastSeenTime);

    if (lastSeenMillis != null) {
      final lastSeenDate = DateTime.fromMillisecondsSinceEpoch(lastSeenMillis);
      if (now.add(const Duration(minutes: 10)).isBefore(lastSeenDate)) {
        return true;
      }
    }
    if (lastSeenMillis == null || now.millisecondsSinceEpoch > lastSeenMillis) {
      await prefs.setInt(_kLastSeenTime, now.millisecondsSinceEpoch);
    }
    return false;
  }
}
