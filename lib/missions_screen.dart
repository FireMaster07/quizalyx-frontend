import 'package:flutter/material.dart';
import 'mission_manager.dart';
import 'main.dart';
import 'l10n/app_localizations.dart';

class MissionsScreen extends StatefulWidget {
  const MissionsScreen({super.key});

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen> {
  Map<String, int> _progressData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    Map<String, int> data = {};
    for (var mission in MissionManager.missions) {
      int val = await MissionManager.getProgress(mission.prefKey);
      data[mission.prefKey] = val;
    }

    if (mounted) {
      setState(() {
        _progressData = data;
        _isLoading = false;
      });
    }
  }

  // --- TRANSLATION HELPER FUNCTIONS ---
  String _getTranslatedTitle(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;
    switch (key) {
      case 'mission_global_title': return loc.mission_global_title;
      case 'mission_title_Math': return loc.mission_title_Math;
      case 'mission_title_Physics': return loc.mission_title_Physics;
      case 'mission_title_Chemistry': return loc.mission_title_Chemistry;
      case 'mission_title_Biology': return loc.mission_title_Biology;
      case 'mission_title_History': return loc.mission_title_History;
      case 'mission_title_Geography': return loc.mission_title_Geography;
      case 'mission_title_Literature': return loc.mission_title_Literature;
      case 'mission_title_Art': return loc.mission_title_Art;
      case 'mission_title_Music': return loc.mission_title_Music;
      case 'mission_title_Sports': return loc.mission_title_Sports;
      case 'mission_title_Technology': return loc.mission_title_Technology;
      case 'mission_title_Software': return loc.mission_title_Software;
      case 'mission_title_Mechanic': return loc.mission_title_Mechanic;
      case 'mission_title_Religion': return loc.mission_title_Religion;
      default: return key;
    }
  }

  String _getTranslatedDesc(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;
    switch (key) {
      case 'mission_global_desc': return loc.mission_global_desc;
      case 'mission_desc_Math': return loc.mission_desc_Math;
      case 'mission_desc_Physics': return loc.mission_desc_Physics;
      case 'mission_desc_Chemistry': return loc.mission_desc_Chemistry;
      case 'mission_desc_Biology': return loc.mission_desc_Biology;
      case 'mission_desc_History': return loc.mission_desc_History;
      case 'mission_desc_Geography': return loc.mission_desc_Geography;
      case 'mission_desc_Literature': return loc.mission_desc_Literature;
      case 'mission_desc_Art': return loc.mission_desc_Art;
      case 'mission_desc_Music': return loc.mission_desc_Music;
      case 'mission_desc_Sports': return loc.mission_desc_Sports;
      case 'mission_desc_Technology': return loc.mission_desc_Technology;
      case 'mission_desc_Software': return loc.mission_desc_Software;
      case 'mission_desc_Mechanic': return loc.mission_desc_Mechanic;
      case 'mission_desc_Religion': return loc.mission_desc_Religion;
      default: return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalStagesCompleted = 0;
    int totalStagesAvailable = 0;

    if (!_isLoading) {
      for (var mission in MissionManager.missions) {
        totalStagesAvailable += mission.targets.length;
        int currentVal = _progressData[mission.prefKey] ?? 0;

        for (int target in mission.targets) {
          if (currentVal >= target) {
            totalStagesCompleted++;
          }
        }
      }
    }

    double globalProgress = totalStagesAvailable == 0
        ? 0
        : totalStagesCompleted / totalStagesAvailable;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(AppLocalizations.of(context)!.careerAchievements),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // TOP SECTION: General Progress
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.totalAchievements,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$totalStagesCompleted / $totalStagesAvailable",
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: globalProgress,
                    minHeight: 12,
                    backgroundColor: AppColors.background,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      globalProgress == 1.0 ? AppColors.success : AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // BOTTOM SECTION: Progressive Mission List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: MissionManager.missions.length,
              itemBuilder: (context, index) {
                final mission = MissionManager.missions[index];
                final currentVal = _progressData[mission.prefKey] ?? 0;

                // --- FIXED PART: OLD LOGIC REMOVED ---
                // Since the keys are now ready inside the Mission object, we call them directly.
                // No need for error checking or split operations anymore.
                String displayTitle = _getTranslatedTitle(context, mission.titleKey);
                String displayDesc = _getTranslatedDesc(context, mission.descKey);
                // ----------------------------------------------

                int currentLevel = 0;
                int currentTarget = mission.targets.first;
                bool isFullyComplete = false;

                for (int i = 0; i < mission.targets.length; i++) {
                  if (currentVal >= mission.targets[i]) {
                    currentLevel = i + 1;
                  } else {
                    currentTarget = mission.targets[i];
                    break;
                  }
                }

                if (currentVal >= mission.targets.last) {
                  isFullyComplete = true;
                  currentLevel = mission.targets.length;
                  currentTarget = mission.targets.last;
                }

                double progressPercent = isFullyComplete
                    ? 1.0
                    : (currentVal / currentTarget).clamp(0.0, 1.0);

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: isFullyComplete
                        ? Border.all(color: AppColors.success.withOpacity(0.5))
                        : Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isFullyComplete
                              ? AppColors.success.withOpacity(0.2)
                              : mission.color.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFullyComplete ? Icons.emoji_events : mission.icon,
                          color: isFullyComplete ? AppColors.success : mission.color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  displayTitle,
                                  style: TextStyle(
                                    color: isFullyComplete ? AppColors.success : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    isFullyComplete ? AppLocalizations.of(context)!.maxLevel : AppLocalizations.of(context)!.levelProgress(currentLevel + 1, mission.targets.length),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              displayDesc,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: progressPercent,
                                      minHeight: 8,
                                      backgroundColor: AppColors.background,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        isFullyComplete ? AppColors.success : mission.color,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  isFullyComplete
                                      ? AppLocalizations.of(context)!.completed
                                      : "$currentVal / $currentTarget",
                                  style: TextStyle(
                                    color: isFullyComplete ? AppColors.success : Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}