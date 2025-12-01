import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Load saved settings from SharedPreferences
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

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.purpleAccent.shade100;

    // deep purple background
    final background = const Color(0xFF1A0033);

    // Shockwave purple divider
    final dividerColor = const Color(0xFF7A3CF4);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF4B0082),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Switch
            SwitchListTile(
              title: Text('Purple Theme', style: TextStyle(color: textColor)),
              value: isPurpleTheme,
              onChanged: (val) {
                setState(() => isPurpleTheme = val);
              },
              activeColor: Colors.purpleAccent.shade400,
            ),
            Divider(color: dividerColor),

            // Number of Questions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Number of Questions', style: TextStyle(color: textColor)),
                DropdownButton<int>(
                  value: numberOfQuestions,
                  dropdownColor: Colors.black,
                  style: TextStyle(color: textColor, fontSize: 16),
                  items: [5, 10, 15].map((e) {
                    return DropdownMenuItem<int>(
                      value: e,
                      child: Text('$e'),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => numberOfQuestions = val);
                  },
                ),
              ],
            ),
            Divider(color: dividerColor),

            // Show Difficulty Switch
            SwitchListTile(
              title: Text('Show Difficulty', style: TextStyle(color: textColor)),
              value: showDifficulty,
              onChanged: (val) {
                setState(() => showDifficulty = val);
              },
              activeColor: Colors.purpleAccent.shade400,
            ),
            Divider(color: dividerColor),

            // Timed Duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Timed Question Duration (s)', style: TextStyle(color: textColor)),
                DropdownButton<int>(
                  value: timedQuestionDuration,
                  dropdownColor: Colors.black,
                  style: TextStyle(color: textColor, fontSize: 16),
                  items: [15, 30, 45].map((e) {
                    return DropdownMenuItem<int>(
                      value: e,
                      child: Text('$e'),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => timedQuestionDuration = val);
                  },
                ),
              ],
            ),
            Divider(color: dividerColor),

            // Endless Mode Duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Endless Mode Duration (s)', style: TextStyle(color: textColor)),
                DropdownButton<int>(
                  value: endlessDuration,
                  dropdownColor: Colors.black,
                  style: TextStyle(color: textColor, fontSize: 16),
                  items: [120, 180, 240].map((e) {
                    return DropdownMenuItem<int>(
                      value: e,
                      child: Text('$e'),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => endlessDuration = val);
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            // SAVE and RESET buttons
            Row(
              children: [
                // Save Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('purple_theme', isPurpleTheme);
                      await prefs.setInt('number_of_questions', numberOfQuestions);
                      await prefs.setBool('show_difficulty', showDifficulty);
                      await prefs.setInt('timed_duration', timedQuestionDuration);
                      await prefs.setInt('endless_duration', endlessDuration);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings saved!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7A3CF4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Save'),
                  ),
                ),

                const SizedBox(width: 16),

                // Reset Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('endless_highscore');

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('High scores reset!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7A3CF4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // BACK Button
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7A3CF4),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Back'),
                ),
              ),
            ),

            const SizedBox(height: 30), // bottom spacing reduced by 50%
          ],
        ),
      ),
    );
  }
}
