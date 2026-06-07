import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'currency_manager.dart';
import 'l10n/app_localizations.dart';

class Mission {
  final String id;
  // We replaced title with titleKey
  final String titleKey;
  // We replaced description with descKey
  final String descKey;
  final List<int> targets;
  final String prefKey;
  final IconData icon;
  final Color color;

  Mission({
    required this.id,
    required this.titleKey,
    required this.descKey,
    required this.targets,
    required this.prefKey,
    required this.icon,
    required this.color,
  });
}

class MissionManager {
  static final List<Mission> missions = [
    // Add into the missions list:

    Mission(
      id: 'global_master',
      titleKey: 'mission_global_title', // "Question Master"
      descKey: 'mission_global_desc',   // "Solve a total of X questions"
      prefKey: 'global_total_questions', // <-- IMPORTANT: We will use this key
      icon: Icons.public_rounded,       // Globe icon
      color: Colors.purpleAccent,
      targets: [100, 250, 500, 1000],   // Targets
    ),
    // ... other missions ...
    // MATHEMATICS
    Mission(
      id: 'math_mastery',
      titleKey: 'mission_title_Math', // We provide the key directly
      descKey: 'mission_desc_Math',
      targets: [20, 50, 100],
      prefKey: 'math_correct',
      icon: Icons.calculate,
      color: const Color(0xFF14B8A6),
    ),
    // PHYSICS
    Mission(
      id: 'phy_mastery',
      titleKey: 'mission_title_Physics',
      descKey: 'mission_desc_Physics',
      targets: [20, 50, 100],
      prefKey: 'physics_correct',
      icon: Icons.electric_bolt,
      color: const Color(0xFF6366F1),
    ),
    // CHEMISTRY
    Mission(
      id: 'chem_mastery',
      titleKey: 'mission_title_Chemistry',
      descKey: 'mission_desc_Chemistry',
      targets: [20, 50, 100],
      prefKey: 'chemistry_correct',
      icon: Icons.science,
      color: const Color(0xFFEC4899),
    ),
    // BIOLOGY
    Mission(
      id: 'bio_mastery',
      titleKey: 'mission_title_Biology',
      descKey: 'mission_desc_Biology',
      targets: [20, 50, 100],
      prefKey: 'biology_correct',
      icon: Icons.pets,
      color: const Color(0xFF84CC16),
    ),
    // HISTORY
    Mission(
      id: 'hist_mastery',
      titleKey: 'mission_title_History',
      descKey: 'mission_desc_History',
      targets: [20, 50, 100],
      prefKey: 'history_correct',
      icon: Icons.history_edu,
      color: const Color(0xFFF59E0B),
    ),
    // GEOGRAPHY
    Mission(
      id: 'geo_mastery',
      titleKey: 'mission_title_Geography',
      descKey: 'mission_desc_Geography',
      targets: [20, 50, 100],
      prefKey: 'geography_correct',
      icon: Icons.public,
      color: const Color(0xFF0EA5E9),
    ),
    // LITERATURE
    Mission(
      id: 'lit_mastery',
      titleKey: 'mission_title_Literature',
      descKey: 'mission_desc_Literature',
      targets: [20, 50, 100],
      prefKey: 'literature_correct',
      icon: Icons.menu_book,
      color: const Color(0xFF8B5CF6),
    ),
    // ART
    Mission(
      id: 'art_mastery',
      titleKey: 'mission_title_Art',
      descKey: 'mission_desc_Art',
      targets: [20, 50, 100],
      prefKey: 'art_correct',
      icon: Icons.palette,
      color: const Color(0xFFD946EF),
    ),
    // MUSIC
    Mission(
      id: 'mus_mastery',
      titleKey: 'mission_title_Music',
      descKey: 'mission_desc_Music',
      targets: [20, 50, 100],
      prefKey: 'music_correct',
      icon: Icons.music_note,
      color: const Color(0xFFF43F5E),
    ),
    // SPORTS
    Mission(
      id: 'sport_mastery',
      titleKey: 'mission_title_Sports',
      descKey: 'mission_desc_Sports',
      targets: [20, 50, 100],
      prefKey: 'sports_correct',
      icon: Icons.sports_basketball,
      color: const Color(0xFFF97316),
    ),
    // TECHNOLOGY
    Mission(
      id: 'tech_mastery',
      titleKey: 'mission_title_Technology',
      descKey: 'mission_desc_Technology',
      targets: [20, 50, 100],
      prefKey: 'technology_correct',
      icon: Icons.computer,
      color: const Color(0xFF3B82F6),
    ),
    // SOFTWARE
    Mission(
      id: 'soft_mastery',
      titleKey: 'mission_title_Software',
      descKey: 'mission_desc_Software',
      targets: [20, 50, 100],
      prefKey: 'software_correct',
      icon: Icons.terminal,
      color: const Color(0xFF10B981),
    ),
    // MECHANIC
    Mission(
      id: 'mech_mastery',
      titleKey: 'mission_title_Mechanic',
      descKey: 'mission_desc_Mechanic',
      targets: [20, 50, 100],
      prefKey: 'mechanic_correct',
      icon: Icons.build,
      color: const Color(0xFF64748B),
    ),
    // RELIGION
    Mission(
      id: 'rel_mastery',
      titleKey: 'mission_title_Religion',
      descKey: 'mission_desc_Religion',
      targets: [20, 50, 100],
      prefKey: 'religion_correct',
      icon: Icons.mosque,
      color: const Color(0xFFA855F7),
    ),
  ];

  static List<Mission> completedMissionsQueue = [];

  // NEW: Account-specific data key (Prefix) generator
  static String _getPrefix() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null ? '${user.uid}_' : 'guest_';
  }

  static Future<int> getProgress(String key) async {
    final prefs = await SharedPreferences.getInstance();
    // Reading with prefix
    return prefs.getInt('${_getPrefix()}${key.toLowerCase()}') ?? 0;
  }

  // UPDATED: Now takes 'context'
  static Future<void> incrementProgress(BuildContext context, String category, int amount) async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = _getPrefix();

    // --- 1. CATEGORY PROGRESS ---
    final String baseCategoryKey = '${category.toLowerCase()}_correct';
    final String fullCategoryKey = '$prefix$baseCategoryKey';

    final int oldVal = prefs.getInt(fullCategoryKey) ?? 0;
    final int newVal = oldVal + amount;

    // Grant points for every correct answer
    await CurrencyManager.addPoints(amount * 10);

    // Check Category Tiers (20, 50, 100)
    int earnedCoins = 0;
    if (oldVal < 20 && newVal >= 20) earnedCoins += 5;
    else if (oldVal < 50 && newVal >= 50) earnedCoins += 7;
    else if (oldVal < 100 && newVal >= 100) earnedCoins += 10;

    await prefs.setInt(fullCategoryKey, newVal);

    // --- 2. GLOBAL TASK PROGRESS ---
    const String baseGlobalKey = 'global_total_questions';
    final String fullGlobalKey = '$prefix$baseGlobalKey';

    final int oldGlobal = prefs.getInt(fullGlobalKey) ?? 0;
    final int newGlobal = oldGlobal + amount;

    // Check Global Tiers
    // 100 questions -> 20 Coins
    if (oldGlobal < 100 && newGlobal >= 100) earnedCoins += 20;
    // 250 questions -> 35 Coins
    else if (oldGlobal < 250 && newGlobal >= 250) earnedCoins += 35;
    // 500 questions -> 70 Coins
    else if (oldGlobal < 500 && newGlobal >= 500) earnedCoins += 70;
    // 1000 questions -> 200 Coins
    else if (oldGlobal < 1000 && newGlobal >= 1000) earnedCoins += 200;

    await prefs.setInt(fullGlobalKey, newGlobal);
    // ---------------------------------------

    // --- 3. COIN NOTIFICATION ---
    // If any coins were earned (Category OR Global)
    if (earnedCoins > 0) {
      await CurrencyManager.addCoins(earnedCoins);

      Future.delayed(const Duration(milliseconds: 500), () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.monetization_on_rounded, color: Color(0xFFFFD700)),
                  const SizedBox(width: 10),
                  Text(
                      AppLocalizations.of(context)!.plusCoinsEarned(earnedCoins), // We call the function defined in the ARB
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      )
                  ),
                ],
              ),
              backgroundColor: Colors.orange[800],
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(16),
            ),
          );
        }
      });
    }

    // --- 4. MISSION COMPLETION QUEUE ---
    // Check both Category AND Global missions safely
    try {
      // Iterate through all missions to find which ones are affected
      for (var mission in missions) {
        int currentProgress = 0;
        int previousProgress = 0;

        // Determine which progress value to check based on mission type
        // We perform the matching check using keys without prefix (raw keys)
        if (mission.prefKey == baseCategoryKey) {
          currentProgress = newVal;      // Category mission
          previousProgress = oldVal;
        } else if (mission.prefKey == baseGlobalKey) {
          currentProgress = newGlobal;   // Global mission
          previousProgress = oldGlobal;
        } else {
          continue; // Skip unrelated missions
        }

        // Check if a target was just reached
        for (int target in mission.targets) {
          if (previousProgress < target && currentProgress >= target) {
            completedMissionsQueue.add(mission);
            break; // No need to check other targets for this mission
          }
        }
      }
    } catch (e) {
      debugPrint("Mission update error: $e");
    }
  }
}