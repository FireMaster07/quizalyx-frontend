import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isPurpleTheme = true;
  int numberOfQuestions = 10;
  bool showDifficulty = true;
  int timedQuestionDuration = 30;
  int endlessDuration = 180;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isPurpleTheme = prefs.getBool('purple_theme') ?? true;
      numberOfQuestions = prefs.getInt('number_of_questions') ?? 10;
      showDifficulty = prefs.getBool('show_difficulty') ?? true;
      timedQuestionDuration = prefs.getInt('timed_duration') ?? 30;
      endlessDuration = prefs.getInt('endless_duration') ?? 180;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('purple_theme', isPurpleTheme);
    await prefs.setInt('number_of_questions', numberOfQuestions);
    await prefs.setBool('show_difficulty', showDifficulty);
    await prefs.setInt('timed_duration', timedQuestionDuration);
    await prefs.setInt('endless_duration', endlessDuration);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Settings saved successfully!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      );
    }
  }

  Future<void> _resetHighScores() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        title: const Text(
          'Reset High Scores?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'This will delete all your high scores. This action cannot be undone.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('endless_highscore');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('High scores reset successfully!'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const SizedBox(height: AppSpacing.md),
          
          // Appearance Section
          _buildSectionHeader('Appearance', Icons.palette_rounded),
          const SizedBox(height: AppSpacing.md),
          _buildSettingCard(
            child: SwitchListTile(
              title: const Text(
                'Purple Theme',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Use purple gradient for question cards',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              value: isPurpleTheme,
              onChanged: (val) => setState(() => isPurpleTheme = val),
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Gameplay Section
          _buildSectionHeader('Gameplay', Icons.gamepad_rounded),
          const SizedBox(height: AppSpacing.md),
          
          _buildSettingCard(
            child: Column(
              children: [
                _buildDropdownRow(
                  label: 'Number of Questions',
                  icon: Icons.format_list_numbered_rounded,
                  value: numberOfQuestions,
                  items: [5, 10, 15, 20],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => numberOfQuestions = val);
                    }
                  },
                ),
                Divider(color: AppColors.surfaceLight, height: 32),
                _buildDropdownRow(
                  label: 'Timed Duration (seconds)',
                  icon: Icons.timer_rounded,
                  value: timedQuestionDuration,
                  items: [15, 30, 45, 60],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => timedQuestionDuration = val);
                    }
                  },
                ),
                Divider(color: AppColors.surfaceLight, height: 32),
                _buildDropdownRow(
                  label: 'Endless Duration (seconds)',
                  icon: Icons.all_inclusive_rounded,
                  value: endlessDuration,
                  items: [120, 180, 240, 300],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => endlessDuration = val);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Display Section
          _buildSectionHeader('Display', Icons.visibility_rounded),
          const SizedBox(height: AppSpacing.md),
          _buildSettingCard(
            child: SwitchListTile(
              title: const Text(
                'Show Difficulty',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Display difficulty level for each question',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              value: showDifficulty,
              onChanged: (val) => setState(() => showDifficulty = val),
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Actions Section
          _buildSectionHeader('Actions', Icons.settings_rounded),
          const SizedBox(height: AppSpacing.md),
          
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  label: 'Save Settings',
                  icon: Icons.save_rounded,
                  onPressed: _saveSettings,
                  isPrimary: true,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildActionButton(
                  label: 'Reset Scores',
                  icon: Icons.restore_rounded,
                  onPressed: _resetHighScores,
                  isPrimary: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryLight],
            ),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: AppSpacing.md),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.surfaceLight,
          width: 1,
        ),
      ),
      child: child,
    );
  }

  Widget _buildDropdownRow({
    required String label,
    required IconData icon,
    required int value,
    required List<int> items,
    required void Function(int?) onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: DropdownButton<int>(
            value: value,
            dropdownColor: AppColors.surfaceLight,
            underline: const SizedBox.shrink(),
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              color: AppColors.primary,
            ),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            items: items.map((e) {
              return DropdownMenuItem<int>(
                value: e,
                child: Text('$e'),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.primary : AppColors.error,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        elevation: 0,
      ),
    );
  }
}