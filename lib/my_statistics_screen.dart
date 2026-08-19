import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'l10n/app_localizations.dart';

class MyStatisticsScreen extends StatelessWidget {
  final User? user;

  // FIXED: The const error in the constructor was resolved
  const MyStatisticsScreen({super.key, required this.user});

  // This function fetches user statistics from Firestore with Cache Support, or SharedPreferences as fallback
  Future<Map<String, String>> _fetchUserStats(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    int totalXp = 0;
    int quizzesPlayed = 0;
    int correctAnswers = 0;
    int totalAnswers = 0;

    // Since the Streak data is kept independent of the prefix, we read it directly
    int dailyStreak = prefs.getInt('daily_streak') ?? 0;

    // --- REGISTERED USER LOGIC ONLY ---
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get(const GetOptions(source: Source.serverAndCache)); // Reads from cache when offline

        if (doc.exists && doc.data() != null) {
          final data = doc.data() as Map<String, dynamic>;
          totalXp = data['totalXp'] ?? 0;
          quizzesPlayed = data['quizzesPlayed'] ?? 0;
          correctAnswers = data['correctAnswers'] ?? 0;
          totalAnswers = data['totalAnswers'] ?? 0;
        }
      } catch (e) {
        debugPrint("Firestore fetch error: $e");
        // If there is no cache on the device, read from local prefs (backup) as a last resort
        final String prefix = '${user!.uid}_';
        totalXp = prefs.getInt('${prefix}total_xp') ?? 0;
        quizzesPlayed = prefs.getInt('${prefix}quizzes_played') ?? 0;
        correctAnswers = prefs.getInt('${prefix}correct_answers') ?? 0;
        totalAnswers = prefs.getInt('${prefix}total_answers') ?? 0;
      }
    }

    // Accuracy calculation (with division by zero protection)
    String currentLanguage = Localizations.localeOf(context).languageCode;
    String accuracy = NumberFormat.percentPattern(currentLanguage).format(0);
    if (totalAnswers > 0) {
      // We define the ratio variable as a pure mathematical fraction (double).
      // Example: 40 / 50 = 0.8
      double ratio = correctAnswers / totalAnswers;
      // The intl library automatically converts 0.85 into 85% (or %85)!
      accuracy = NumberFormat.percentPattern(currentLanguage).format(ratio);
    }

    // Returning a map of statistics to be displayed in the UI
    return {
      "xp": "$totalXp XP",
      "played": "$quizzesPlayed",
      "accuracy": accuracy,
      "streak": AppLocalizations.of(context)!.daysCount(dailyStreak),
    };
  }

  @override
  Widget build(BuildContext context) {
    // For internet check, you can connect FirebaseAuth's current state or an internet control mechanism here.
    // We will still force Firebase to feed from the local cache.

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.myStatistics,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context), // Back button navigation
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background gradient decoration
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.5,
                colors: [
                  AppColors.primary.withOpacity(0.15),
                  AppColors.background,
                  AppColors.background,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // OFFLINE STRIP
                if (user != null)
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      // If an error occurs while accessing Firestore or there is no internet, show the strip
                      if (snapshot.hasError ||
                          snapshot.connectionState == ConnectionState.none) {
                        return Container(
                          width: double.infinity,
                          color: Colors.redAccent.withOpacity(0.2),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_off_rounded,
                                color: Colors.redAccent,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.offlineModeDataFromDevice,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                // Your current GridView structure should remain inside Expanded
                Expanded(
                  child: FutureBuilder<Map<String, String>>(
                    future: _fetchUserStats(context),
                    builder: (context, snapshot) {
                      // Show loading spinner while data is being fetched
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      }
                      final stats = snapshot.data!; // Data successfully fetched
                      return GridView.count(
                        padding: const EdgeInsets.all(24),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio:
                            0.80, // Ratio preserved to prevent pixel overflow
                        children: [
                          _buildStatCard(
                            Icons.emoji_events_rounded,
                            AppLocalizations.of(context)!.totalScore,
                            stats["xp"]!,
                            AppColors.accentOrange,
                          ),
                          _buildStatCard(
                            Icons.extension_rounded,
                            AppLocalizations.of(context)!.quizzesPlayed,
                            stats["played"]!,
                            AppColors.accentBlue,
                          ),
                          _buildStatCard(
                            Icons.bar_chart_rounded,
                            AppLocalizations.of(context)!.accuracyRate,
                            stats["accuracy"]!,
                            AppColors.success,
                          ),
                          _buildStatCard(
                            Icons.local_fire_department_rounded,
                            AppLocalizations.of(context)!.dailyStreak,
                            stats["streak"]!,
                            AppColors.error,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build a statistic card with icon, title, and value
  Widget _buildStatCard(
    IconData icon,
    String title,
    String value,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container with background circle
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const Spacer(), // Adds flexible space between icon and text
          // FittedBox ensures text scales down instead of overflowing
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }
}
