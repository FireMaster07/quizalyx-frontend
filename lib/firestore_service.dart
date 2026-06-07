import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Internal helper method to check device’s internet status
  Future<bool> _hasConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // LOCAL TO CLOUD: Backs up everything from local storage to Firestore
  Future<void> saveUserDataToCloud() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return; // If user is guest, don’t perform operation

    // If there’s no internet, don’t attempt to write to cloud and freeze the app
    if (!await _hasConnection()) return;

    final prefs = await SharedPreferences.getInstance();
    final prefix = '${user.uid}_';

    try {
      final userData = {
        'last_updated': FieldValue.serverTimestamp(),
        'stats': {
          'total_xp': prefs.getInt('${prefix}total_xp') ?? 0,
          'quizzes_played': prefs.getInt('${prefix}quizzes_played') ?? 0,
          'correct_answers': prefs.getInt('${prefix}correct_answers') ?? 0,
          'total_answers': prefs.getInt('${prefix}total_answers') ?? 0,
          'daily_streak': prefs.getInt('${prefix}daily_streak') ?? 0,
        },
        'currency': {
          'coins': prefs.getInt('${prefix}user_wallet_coins') ?? 0,
          'points': prefs.getInt('${prefix}user_wallet_points') ?? 0,
          'inv_5050': prefs.getInt('${prefix}inv_5050') ?? 0,
          'inv_time': prefs.getInt('${prefix}inv_time') ?? 0,
          'active_theme': prefs.getString('${prefix}active_theme') ?? 'default',
          'special_bundle_count': prefs.getInt('${prefix}special_bundle_count') ?? 0,
        },
        'missions': {
          'global_total_questions': prefs.getInt('${prefix}global_total_questions') ?? 0,
          'math_correct': prefs.getInt('${prefix}math_correct') ?? 0,
          'physics_correct': prefs.getInt('${prefix}physics_correct') ?? 0,
          'chemistry_correct': prefs.getInt('${prefix}chemistry_correct') ?? 0,
          'biology_correct': prefs.getInt('${prefix}biology_correct') ?? 0,
          'history_correct': prefs.getInt('${prefix}history_correct') ?? 0,
          'geography_correct': prefs.getInt('${prefix}geography_correct') ?? 0,
          'literature_correct': prefs.getInt('${prefix}literature_correct') ?? 0,
          'art_correct': prefs.getInt('${prefix}art_correct') ?? 0,
          'music_correct': prefs.getInt('${prefix}music_correct') ?? 0,
          'sports_correct': prefs.getInt('${prefix}sports_correct') ?? 0,
          'technology_correct': prefs.getInt('${prefix}technology_correct') ?? 0,
          'software_correct': prefs.getInt('${prefix}software_correct') ?? 0,
          'mechanic_correct': prefs.getInt('${prefix}mechanic_correct') ?? 0,
          'religion_correct': prefs.getInt('${prefix}religion_correct') ?? 0,
        }
      };

      // Additionally, for the global Leaderboard, write only name and score separately
      await _db.collection('leaderboard').doc(user.uid).set({
        'name': user.displayName ?? 'Anonymous Player',
        'score': prefs.getInt('${prefix}total_xp') ?? 0,
        'last_active': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Save the full detailed profile
      await _db.collection('users').doc(user.uid).set(userData, SetOptions(merge: true));
    } catch (e) {
      print("Cloud Save Error: $e");
    }
  }

  // CLOUD TO LOCAL: Downloads data to phone when logging in on a new device
  Future<void> loadUserDataFromCloud() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || !await _hasConnection()) return;

    try {
      final doc = await _db.collection('users').doc(user.uid).get();
      if (!doc.exists) return;

      final data = doc.data();
      if (data == null) return;

      final prefs = await SharedPreferences.getInstance();
      final prefix = '${user.uid}_';

      // 1. Download statistics
      if (data['stats'] != null) {
        final stats = data['stats'] as Map<String, dynamic>;
        await prefs.setInt('${prefix}total_xp', stats['total_xp'] ?? 0);
        await prefs.setInt('${prefix}quizzes_played', stats['quizzes_played'] ?? 0);
        await prefs.setInt('${prefix}correct_answers', stats['correct_answers'] ?? 0);
        await prefs.setInt('${prefix}total_answers', stats['total_answers'] ?? 0);
        await prefs.setInt('${prefix}daily_streak', stats['daily_streak'] ?? 0);
      }

      // 2. Download wallet and inventory
      if (data['currency'] != null) {
        final curr = data['currency'] as Map<String, dynamic>;
        await prefs.setInt('${prefix}user_wallet_coins', curr['coins'] ?? 0);
        await prefs.setInt('${prefix}user_wallet_points', curr['points'] ?? 0);
        await prefs.setInt('${prefix}inv_5050', curr['inv_5050'] ?? 0);
        await prefs.setInt('${prefix}inv_time', curr['inv_time'] ?? 0);
        await prefs.setString('${prefix}active_theme', curr['active_theme'] ?? 'default');
        await prefs.setInt('${prefix}special_bundle_count', curr['special_bundle_count'] ?? 0);
      }

      // 3. Download mission progress
      if (data['missions'] != null) {
        final miss = data['missions'] as Map<String, dynamic>;
        miss.forEach((key, value) async {
          await prefs.setInt('$prefix$key', value ?? 0);
        });
      }
    } catch (e) {
      print("Cloud Load Error: $e");
    }
  }
}
