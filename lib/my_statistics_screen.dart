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

  // This function fetches user statistics from local storage (SharedPreferences)
  Future<Map<String, String>> _fetchUserStats(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Assign a unique prefix depending on the user status
    // If logged in, use UID; if guest, use "guest_"
    final String prefix = user != null ? '${user!.uid}_' : 'guest_';

    // Data is read using keys completely independent of memory
    int totalXp = prefs.getInt('${prefix}total_xp') ?? 0;
    int quizzesPlayed = prefs.getInt('${prefix}quizzes_played') ?? 0;
    int correctAnswers = prefs.getInt('${prefix}correct_answers') ?? 0;
    int totalAnswers = prefs.getInt('${prefix}total_answers') ?? 0;
    int dailyStreak = prefs.getInt('${prefix}daily_streak') ?? 0;

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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.myStatistics, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
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
            // FutureBuilder waits until data arrives before showing the screen
            child: FutureBuilder<Map<String, String>>(
              future: _fetchUserStats(context),
              builder: (context, snapshot) {
                // Show loading spinner while data is being fetched
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: AppColors.primary));
                }

                // Show error message if data could not be loaded
                if (snapshot.hasError) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.dataLoadError, style: const TextStyle(color: Colors.white)),
                  );
                }

                // Data successfully fetched
                final stats = snapshot.data!;

                return GridView.count(
                  padding: const EdgeInsets.all(24),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.80, // Ratio preserved to prevent pixel overflow
                  children: [
                    _buildStatCard(Icons.emoji_events_rounded, AppLocalizations.of(context)!.totalScore, stats["xp"]!, AppColors.accentOrange),
                    _buildStatCard(Icons.extension_rounded, AppLocalizations.of(context)!.quizzesPlayed, stats["played"]!, AppColors.accentBlue),
                    _buildStatCard(Icons.bar_chart_rounded, AppLocalizations.of(context)!.accuracyRate, stats["accuracy"]!, AppColors.success),
                    _buildStatCard(Icons.local_fire_department_rounded, AppLocalizations.of(context)!.dailyStreak, stats["streak"]!, AppColors.error),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build a statistic card with icon, title, and value
  Widget _buildStatCard(IconData icon, String title, String value, Color iconColor) {
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
            child: Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(title, style: const TextStyle(fontSize: 14, color: Colors.white54)),
          ),
        ],
      ),
    );
  }
}
