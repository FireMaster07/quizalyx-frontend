import 'package:flutter/material.dart';
import 'main.dart';
import 'question_screen.dart';
import 'l10n/app_localizations.dart';

class TopicSelectionScreen extends StatelessWidget {
  final String mode;
  final VoidCallback onStopMusic;

  const TopicSelectionScreen({
    super.key,
    required this.mode,
    required this.onStopMusic,
  });

  // We removed the 'name' field because we will handle the translation dynamically through 'id'
  final List<Map<String, dynamic>> topics = const [
    {'id': 'Math', 'icon': Icons.calculate, 'color': Color(0xFF14B8A6)},
    {'id': 'Physics', 'icon': Icons.electric_bolt, 'color': Color(0xFF6366F1)},
    {'id': 'Chemistry', 'icon': Icons.water_drop, 'color': Color(0xFFEC4899)},
    {'id': 'Biology', 'icon': Icons.pets, 'color': Color(0xFF84CC16)},
    {'id': 'History', 'icon': Icons.history_edu, 'color': Color(0xFFF59E0B)},
    {'id': 'Geography', 'icon': Icons.public, 'color': Color(0xFF0EA5E9)},
    {'id': 'Literature', 'icon': Icons.menu_book, 'color': Color(0xFF8B5CF6)},
    {'id': 'Art', 'icon': Icons.palette, 'color': Color(0xFFD946EF)},
    {'id': 'Music', 'icon': Icons.music_note, 'color': Color(0xFFF43F5E)},
    {'id': 'Sports', 'icon': Icons.sports_basketball, 'color': Color(0xFFF97316)},
    {'id': 'Technology', 'icon': Icons.computer, 'color': Color(0xFF3B82F6)},
    {'id': 'Software', 'icon': Icons.terminal, 'color': Color(0xFF10B981)},
    {'id': 'Mechanic', 'icon': Icons.build, 'color': Color(0xFF64748B)},
    {'id': 'Religion', 'icon': Icons.mosque, 'color': Color(0xFFA855F7)},
  ];

  // --- TRANSLATION HELPER FUNCTION ---
  String _getTranslatedTopic(BuildContext context, String topicId) {
    final loc = AppLocalizations.of(context)!;
    switch (topicId) {
      case 'Math': return loc.mission_title_Math;
      case 'Physics': return loc.mission_title_Physics;
      case 'Chemistry': return loc.mission_title_Chemistry;
      case 'Biology': return loc.mission_title_Biology;
      case 'History': return loc.mission_title_History;
      case 'Geography': return loc.mission_title_Geography;
      case 'Literature': return loc.mission_title_Literature;
      case 'Art': return loc.mission_title_Art;
      case 'Music': return loc.mission_title_Music;
      case 'Sports': return loc.mission_title_Sports;
      case 'Technology': return loc.mission_title_Technology;
      case 'Software': return loc.mission_title_Software;
      case 'Mechanic': return loc.mission_title_Mechanic;
      case 'Religion': return loc.mission_title_Religion;
      default: return topicId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(AppLocalizations.of(context)!.selectTopic),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 80),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.1,
          ),
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final topic = topics[index];
            return _buildTopicCard(context, topic);
          },
        ),
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, Map<String, dynamic> topic) {
    return GestureDetector(
      key: ValueKey('topic_${topic['id']}_button'),
      onTap: () {
        if (mode == 'endless') {
          onStopMusic();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => QuestionScreen(
                mode: mode,
                category: topic['id'],
                difficulty: 'Mixed',
              ),
            ),
          );
        } else {
          _showDifficultySelection(context, topic);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: (topic['color'] as Color).withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: (topic['color'] as Color).withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (topic['color'] as Color).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                topic['icon'] as IconData,
                color: topic['color'] as Color,
                size: 32,
              ),
            ),
            const SizedBox(height: 12),
            // UPDATE: Show the translated name
            Text(
              _getTranslatedTopic(context, topic['id']),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDifficultySelection(BuildContext context, Map<String, dynamic> topic) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // UPDATE: To make it appear like "Math Difficulty"
            Text(
              AppLocalizations.of(context)!.topicDifficulty(_getTranslatedTopic(context, topic['id'])),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // UPDATE: We are now fetching the button labels from the dictionary
            _buildDifficultyButton(
                context,
                topic['id'],
                AppLocalizations.of(context)!.beginner, // The one shown on the screen (Initial)
                'Easy', // The one that goes into JSON (Immutable)
                AppColors.success
            ),
            const SizedBox(height: AppSpacing.md),
            _buildDifficultyButton(
                context,
                topic['id'],
                AppLocalizations.of(context)!.intermediate, // Intermediate level
                'Medium', // The one that goes into JSON
                AppColors.warning
            ),
            const SizedBox(height: AppSpacing.md),
            _buildDifficultyButton(
                context,
                topic['id'],
                AppLocalizations.of(context)!.advanced, // Advanced level
                'Hard', // The one that goes into JSON
                AppColors.error
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(
      BuildContext context,
      String topicId,
      String label, // The translated text that will appear on the screen
      String jsonValue, // The English value that will run in the background (Easy/Medium/Hard)
      Color color,
      ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        key: ValueKey('difficulty_${jsonValue}_button'),
        onPressed: () {
          Navigator.pop(context);
          onStopMusic();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => QuestionScreen(
                mode: mode,
                category: topicId,
                difficulty: jsonValue, // This part must always remain in English so that it matches the JSON
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.2),
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(color: color, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          elevation: 0,
        ),
        child: Text(
          label, // Show the translated text
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}