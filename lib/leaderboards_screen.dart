import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'main.dart';
import 'l10n/app_localizations.dart';

class LeaderboardsScreen extends StatelessWidget {
  const LeaderboardsScreen({super.key});

  // THIS WILL BE YOUR FUTURE DATABASE CONNECTION (Firestore)
  Future<List<Map<String, dynamic>>> _fetchGlobalLeaderboard() async {
    try {
      // 1. Check internet connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result[0].rawAddress.isNotEmpty == false) {
        throw const SocketException('offline');
      }

      // 2. Fetch scores from Firestore, order by descending (highest first), and limit to top 10 players
      final snapshot = await FirebaseFirestore.instance
          .collection('leaderboard')
          .orderBy('score', descending: true)
          .limit(10)
          .get();

      // 3. Convert the fetched data into a list
      return snapshot.docs.map((doc) => doc.data()).toList();

    } on SocketException catch (_) {
      throw Exception('offline');
    } catch (e) {
      print("Leaderboard Fetch Error: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(AppLocalizations.of(context)!.leaderboards),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchGlobalLeaderboard(),
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          // 2. Error State (Offline Status Check)
          if (snapshot.hasError) {
            if (snapshot.error.toString().contains('offline')) {
              // Exactly as you wanted: a stylish warning centered on the screen
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off_rounded, size: 80, color: AppColors.textSecondary),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.offlineTitle,
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppLocalizations.of(context)!.leaderboardsOfflineDesc,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.4),
                      ),
                    ],
                  ),
                ),
              );
            }
            // If there is another error, show a standard error message
            return Center(
              child: Text(AppLocalizations.of(context)!.unexpectedError, style: const TextStyle(color: Colors.white)),
            );
          }

          final leaderboardData = snapshot.data ?? [];

          // 3. EMPTY LIST STATE (If there are no players in the database)
          if (leaderboardData.isEmpty) {
            return Center(
              child: Padding(
                // A safety margin of 32 pixels has been added to the right and left sides of the screen
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.emoji_events_outlined,
                      size: 80,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.noOnePlayedYet,
                      textAlign: TextAlign.center, // The text has been centered
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.beTheFirstToPlay,
                      textAlign: TextAlign.center, // The text has been centered
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // 4. IF DATA EXISTS, DRAW THE SCREEN (Your original code)
          return Column(
            children: [
              // Top Trophy Section
              Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.2),
                      AppColors.background,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.warning, AppColors.accentOrange],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.warning.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.emoji_events_rounded,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      AppLocalizations.of(context)!.topPlayers,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      AppLocalizations.of(context)!.challengeThem,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Podium (Top 3 Players)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (leaderboardData.length > 1)
                      _buildPodiumCard(
                        context,
                        rank: 2,
                        name: leaderboardData[1]['name'],
                        score: leaderboardData[1]['score'],
                        height: 100,
                        color: const Color(0xFFC0C0C0),
                      ),
                    const SizedBox(width: AppSpacing.sm),
                    if (leaderboardData.isNotEmpty)
                      _buildPodiumCard(
                        context,
                        rank: 1,
                        name: leaderboardData[0]['name'],
                        score: leaderboardData[0]['score'],
                        height: 130,
                        color: const Color(0xFFFFD700),
                      ),
                    const SizedBox(width: AppSpacing.sm),
                    if (leaderboardData.length > 2)
                      _buildPodiumCard(
                        context,
                        rank: 3,
                        name: leaderboardData[2]['name'],
                        score: leaderboardData[2]['score'],
                        height: 80,
                        color: const Color(0xFFCD7F32),
                      ),
                  ],
                ),
              ),

              // Remaining Players
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  itemCount: leaderboardData.length > 3
                      ? leaderboardData.length - 3
                      : 0,
                  itemBuilder: (context, index) {
                    final actualIndex = index + 3;
                    final item = leaderboardData[actualIndex];
                    return _buildLeaderboardItem(
                      rank: actualIndex + 1,
                      name: item['name'],
                      score: item['score'],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _buildPodiumCard(
  BuildContext context, {
  required int rank,
  required String name,
  required int score,
  required double height,
  required Color color,
}) {
  IconData medal;
  switch (rank) {
    case 1:
      medal = Icons.workspace_premium_rounded;
      break;
    case 2:
      medal = Icons.military_tech_rounded;
      break;
    default:
      medal = Icons.grade_rounded;
  }

  return Column(
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(medal, color: Colors.white, size: 35),
      ),
      const SizedBox(height: AppSpacing.sm),
      // Names are proper nouns, they are not translated.
      Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: AppSpacing.xs),
      // CORRECTION 4: The score number remains, the word "pts" is translated.
      Text(
        '$score ${AppLocalizations.of(context)!.pts}',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      Container(
        width: 80,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.md),
          ),
          border: Border.all(color: color.withOpacity(0.5), width: 2),
        ),
        child: Center(
          child: Text(
            '#$rank',
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildLeaderboardItem({
  required int rank,
  required String name,
  required int score,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: AppSpacing.md),
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.md),
      border: Border.all(color: AppColors.surfaceLight, width: 1),
    ),
    child: Row(
      children: [
        // Rank badge
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.3),
                AppColors.primaryDark.withOpacity(0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          // CORRECTION 5: The rank number is dynamic, it is not translated.
          child: Center(
            child: Text(
              '#$rank', // AppLocalizations.get() REMOVED
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),

        // Avatar (First letter of the name)
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryLight, AppColors.primary],
            ),
            shape: BoxShape.circle,
          ),
          // CORRECTION 6: The initial letter is dynamic, it is not translated.
          child: Center(
            child: Text(
              name[0], // AppLocalizations.get() REMOVED
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),

        // Name
        Expanded(
          // CORRECTION 7: The name is dynamic, it is not translated.
          child: Text(
            name, // AppLocalizations.get() REMOVED
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Score
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(
              color: AppColors.success.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.stars_rounded, color: AppColors.success, size: 16),
              const SizedBox(width: 4),
              // CORRECTION 8: The score number is dynamic, it is not translated.
              Text(
                '$score', // AppLocalizations.get() REMOVED
                style: TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
