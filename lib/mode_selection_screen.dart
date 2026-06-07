import 'package:QuizAlyx/topic_selection_screen.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'l10n/app_localizations.dart';

class ModeSelectionDialog extends StatelessWidget { // We named it Dialog
  final Future<void> Function() onStopMusic;

  const ModeSelectionDialog({
    super.key,
    required this.onStopMusic,
  });

  @override
  Widget build(BuildContext context) {
    // Instead of Scaffold, we return a Dialog
    return Dialog(
      backgroundColor: Colors.transparent, // Make background transparent so our custom design shows
      insetPadding: const EdgeInsets.all(20), // Margin from edges
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface, // Background color of the window (dark gray/navy etc.)
          borderRadius: BorderRadius.circular(24), // Rounded corners
          border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 2), // Stylish border
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Take space only as much as content (don’t cover full screen)
          children: [
            // --- TITLE AND CLOSE BUTTON ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.selectGameMode,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context), // Closes the window
                  icon: const Icon(Icons.close_rounded, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- MODE LIST ---
            // We use SingleChildScrollView so it doesn’t overflow on small screens
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildModeCard(
                      context,
                      icon: Icons.menu_book_rounded,
                      title: AppLocalizations.of(context)!.modeClassic,
                      description: AppLocalizations.of(context)!.modeClassicDesc,
                      color: AppColors.success,
                      mode: 'classic',
                    ),
                    const SizedBox(height: 16),
                    _buildModeCard(
                      context,
                      icon: Icons.timer_rounded,
                      title: AppLocalizations.of(context)!.modeTimed,
                      description: AppLocalizations.of(context)!.modeTimedDesc,
                      color: AppColors.warning,
                      mode: 'timed',
                    ),
                    const SizedBox(height: 16),
                    _buildModeCard(
                      context,
                      icon: Icons.all_inclusive_rounded,
                      title: AppLocalizations.of(context)!.modeEndless,
                      description: AppLocalizations.of(context)!.modeEndlessDesc,
                      color: AppColors.accentBlue,
                      mode: 'endless',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        required Color color,
        required String mode,
      }) {
    return Material( // Material widget is required for ripple effect
      color: Colors.transparent,
      child: InkWell(
        key: ValueKey('mode_${mode}_button'),
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // First close the current Dialog (window)
          Navigator.pop(context);

          // Then navigate to Topic screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TopicSelectionScreen(
                mode: mode,
                onStopMusic: onStopMusic,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1), // Lightly tinted background
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: color, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}