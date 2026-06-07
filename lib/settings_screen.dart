import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'currency_manager.dart';
import 'l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  // --- Theme Variables ---
  bool _hasGoldTheme = false;
  bool _hasDiamondTheme = false;
  String _activeTheme = 'default';

  // --- Gameplay Variables ---
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

    final goldInv = await CurrencyManager.getInventory('theme_gold');
    final diamondInv = await CurrencyManager.getInventory('theme_diamond');
    final currentTheme = await CurrencyManager.getActiveTheme();

    if (mounted) {
      setState(() {
        // Theme States
        _hasGoldTheme = goldInv > 0;
        _hasDiamondTheme = diamondInv > 0;
        _activeTheme = currentTheme;

        // Gameplay States
        numberOfQuestions = prefs.getInt('number_of_questions') ?? 10;
        showDifficulty = prefs.getBool('show_difficulty') ?? true;
        timedQuestionDuration = prefs.getInt('timed_duration') ?? 30;
        endlessDuration = prefs.getInt('endless_duration') ?? 180;
      });
    }
  }

  Future<void> _setTheme(String themeName) async {
    await CurrencyManager.setActiveTheme(themeName);
    AppColors.themeNotifier.value = themeName;
    setState(() {
      _activeTheme = themeName;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('number_of_questions', numberOfQuestions);
    await prefs.setBool('show_difficulty', showDifficulty);
    await prefs.setInt('timed_duration', timedQuestionDuration);
    await prefs.setInt('endless_duration', endlessDuration);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.settingsSaved),
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
        title: Text(
          AppLocalizations.of(context)!.resetHighScoresTitle,
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          AppLocalizations.of(context)!.resetHighScoresDesc,
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: Text(AppLocalizations.of(context)!.reset),
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
            content: Text(AppLocalizations.of(context)!.highScoresResetSuccess),
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
        title: Text(AppLocalizations.of(context)!.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const SizedBox(height: AppSpacing.md),

          // --- LANGUAGE SECTION ---
          _buildSectionHeader(AppLocalizations.of(context)!.language, Icons.language_rounded),
          const SizedBox(height: AppSpacing.md),
          _buildSettingCard(
            child: Row(
              children: [
                Icon(Icons.translate_rounded, color: AppColors.primary, size: 20),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.language,
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
                  child: DropdownButton<String>(
                    value: Localizations.localeOf(context).languageCode,
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
                    items: const [
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'tr', child: Text('Türkçe')),
                      DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                      DropdownMenuItem(value: 'fr', child: Text('Français')),
                      DropdownMenuItem(value: 'it', child: Text('Italiano')),
                      DropdownMenuItem(value: 'es', child: Text('Español')),
                      DropdownMenuItem(value: 'pt', child: Text('Português')),
                      DropdownMenuItem(value: 'ar', child: Text('العربية')),
                      DropdownMenuItem(value: 'zh', child: Text('中文')),
                      DropdownMenuItem(value: 'ja', child: Text('日本語')),
                      DropdownMenuItem(value: 'ru', child: Text('Русский')),
                      DropdownMenuItem(value: 'hi', child: Text('हिन्दी')),
                      DropdownMenuItem(value: 'el', child: Text('Ελληνικά')),
                      DropdownMenuItem(value: 'fa', child: Text('فارسی')),
                      DropdownMenuItem(value: 'ko', child: Text('한국어')),
                    ],
                    onChanged: (String? newLang) {
                      if (newLang != null) {
                        AppLanguage.changeLanguage(newLang);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // --- APPEARANCE SECTION ---
          _buildSectionHeader(AppLocalizations.of(context)!.appearance, Icons.palette_rounded),
          const SizedBox(height: AppSpacing.md),
          _buildSettingCard(
            child: Column(
              children: [
                if (_hasGoldTheme)
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.goldTheme, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text(AppLocalizations.of(context)!.premiumGoldLook, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                    activeColor: const Color(0xFFFFD700),
                    secondary: const Icon(Icons.palette_rounded, color: Color(0xFFFFD700)),
                    value: _activeTheme == 'gold',
                    onChanged: (val) {
                      _setTheme(val ? 'gold' : 'default');
                    },
                    contentPadding: EdgeInsets.zero,
                  )
                else
                  _buildLockedThemeTile(AppLocalizations.of(context)!.goldTheme, AppLocalizations.of(context)!.unlockInStore),

                const Divider(color: Colors.white10),

                if (_hasDiamondTheme)
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.diamondTheme, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text(AppLocalizations.of(context)!.legendaryDiamondLook, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                    activeColor: const Color(0xFF00E5FF),
                    secondary: const Icon(Icons.diamond_rounded, color: Color(0xFF00E5FF)),
                    value: _activeTheme == 'diamond',
                    onChanged: (val) {
                      _setTheme(val ? 'diamond' : 'default');
                    },
                    contentPadding: EdgeInsets.zero,
                  )
                else
                  _buildLockedThemeTile(AppLocalizations.of(context)!.diamondTheme, AppLocalizations.of(context)!.unlockInStore1500),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // --- GAMEPLAY SECTION ---
          _buildSectionHeader(AppLocalizations.of(context)!.gameplay, Icons.gamepad_rounded),
          const SizedBox(height: AppSpacing.md),
          _buildSettingCard(
            child: Column(
              children: [
                _buildDropdownRow(
                  label: AppLocalizations.of(context)!.numberOfQuestions,
                  icon: Icons.format_list_numbered_rounded,
                  value: numberOfQuestions,
                  items: [5, 10, 15, 20],
                  onChanged: (val) => setState(() => numberOfQuestions = val!),
                ),
                const Divider(color: AppColors.surfaceLight, height: 32),
                _buildDropdownRow(
                  label: AppLocalizations.of(context)!.timedDurationSec,
                  icon: Icons.timer_rounded,
                  value: timedQuestionDuration,
                  items: [15, 30, 45, 60],
                  onChanged: (val) => setState(() => timedQuestionDuration = val!),
                ),
                const Divider(color: AppColors.surfaceLight, height: 32),
                _buildDropdownRow(
                  label: AppLocalizations.of(context)!.endlessDurationSec,
                  icon: Icons.all_inclusive_rounded,
                  value: endlessDuration,
                  items: [120, 180, 240, 300],
                  onChanged: (val) => setState(() => endlessDuration = val!),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // --- DISPLAY SECTION ---
          _buildSectionHeader(AppLocalizations.of(context)!.display, Icons.visibility_rounded),
          const SizedBox(height: AppSpacing.md),
          _buildSettingCard(
            child: SwitchListTile(
              title: Text(AppLocalizations.of(context)!.showDifficulty, style: TextStyle(color: Colors.white)),
              subtitle: Text(AppLocalizations.of(context)!.showDifficultyDesc, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              value: showDifficulty,
              onChanged: (val) => setState(() => showDifficulty = val),
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // --- ACTIONS SECTION ---
          _buildSectionHeader(AppLocalizations.of(context)!.actions, Icons.settings_rounded),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  label: AppLocalizations.of(context)!.saveSettings,
                  icon: Icons.save_rounded,
                  onPressed: _saveSettings,
                  isPrimary: true,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildActionButton(
                  label: AppLocalizations.of(context)!.resetScores,
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

  // --- HELPER WIDGETS ---

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

  Widget _buildLockedThemeTile(String title, String subtitle) {
    return ListTile(
      leading: const Icon(Icons.lock_outline, color: AppColors.textSecondary),
      title: Text(title, style: const TextStyle(color: AppColors.textSecondary)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textTertiary, fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
      contentPadding: EdgeInsets.zero,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.visitStoreToUnlock), duration: Duration(seconds: 1)),
        );
      },
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