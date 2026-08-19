import 'package:flutter/material.dart';
import 'main.dart'; // AppColors için
import 'mode_selection_screen.dart'; // Old QuizAlyx selection screen
import 'word_alyx_screen.dart'; // New WorldAlyx screen
import 'l10n/app_localizations.dart';

class GameSelectionDialog extends StatelessWidget {
  final Future<void> Function() onStopMusic;

  const GameSelectionDialog({
    super.key,
    required this.onStopMusic,
  });

  @override
  Widget build(BuildContext context) {
    // We preserve the transparent background and margin structure in ModeSelectionDialog
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface, // Dark background of our window
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- TOP TITLE AND CLOSE BUTTON ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.chooseYourGame, // <-- CHANGING PART
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- TWO GAME BUTTONS SIDE BY SIDE ---
            Row(
              children: [
                // LEFT: WORDALYX BUTTON
                Expanded(
                  child: _buildGameCard(
                    context,
                    title: "WordAlyx",
                    textColor: Colors.orangeAccent, // Neon Orange
                    onTap: () async {
                      await onStopMusic(); // 1. STOP THE HOME MUSIC COMPLETELY
                      if (context.mounted) {
                        Navigator.pop(context); // 2. Close the dialog
                        Navigator.push( // 3. Go to the WordAlyx screen (Its own music will start here)
                          context,
                          MaterialPageRoute(builder: (_) => const WordAlyxScreen()),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // RIGHT: QUIZALYX BUTTON
                Expanded(
                  child: _buildGameCard(
                    context,
                    title: "QuizAlyx",
                    textColor: Colors.lightGreenAccent, // Light Green
                    onTap: () {
                      Navigator.pop(context); // Close this dialog first
                      // Redirect to the original QuizAlyx mode selection (Classic, Timed, Endless)
                      showDialog(
                        context: context,
                        builder: (_) => ModeSelectionDialog(onStopMusic: onStopMusic),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- CUSTOM GLOW EFFECT BUTTON DESIGN ---
  Widget _buildGameCard(BuildContext context, {required String title, required Color textColor, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 120, // We make the buttons close to a square, a full size
          decoration: BoxDecoration(
            color: const Color(0xFF130E1F), // Very dark purple/black button background
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: textColor.withOpacity(0.4), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: textColor.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                color: textColor, // The actual color of the letter
                shadows: const [
                  // Here is the thin white aura (glow) sheath around the letter
                  Shadow(color: Colors.white, blurRadius: 4),
                  Shadow(color: Colors.white, blurRadius: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}