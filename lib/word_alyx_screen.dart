import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'dart:async'; // Added for the timer
import 'l10n/app_localizations.dart';
import 'audio_manager.dart';
import 'main.dart'; // ADDED

class WordAlyxScreen extends StatefulWidget {
  const WordAlyxScreen({super.key});

  @override
  State<WordAlyxScreen> createState() => _WordAlyxScreenState();
}

class _WordAlyxScreenState extends State<WordAlyxScreen> with WidgetsBindingObserver {
  // We generate 16 random letters for development phase
  late List<String> _gridLetters;

  // We will keep the indices of the letters selected by the user
  final List<int> _selectedIndices = [];

  // --- NEW GAME MECHANIC VARIABLES ---
  Timer? _timer;
  int _secondsLeft = 180; // 3 minutes = 180 seconds
  int _score = 0;
  bool _isGameOver = false;

  // The list where we will keep the found words and their scores
  final List<Map<String, dynamic>> _foundWords = [];

  Set<String> _validWordsSet = {};
  bool _isDictionaryLoaded = false;

  // --- QUIZALYX PURPLE & BLACK THEME COLORS ---
  final Color bgColor = const Color(
    0xFF0D0B14,
  ); // Very dark black/purple background
  final Color surfaceColor = const Color(0xFF1E182D); // Card Background
  final Color primaryColor = const Color(0xFFA855F7); // Bright Neon/Purple
  final Color accentColor = const Color(
    0xFFFACC15,
  ); // Yellow accent for points, etc.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Start listening to application state
    // Start WordAlyx music when the page opens
    AudioManager.instance.playWordAlyxMusic();
    _generateRandomLetters();
    _startTimer(); // Start the timer
    _loadDictionary(); // NEW: LOAD DICTIONARY
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove listener
    _timer?.cancel(); // Stop the timer when the page closes
    AudioManager.instance.playHomeMusic(); // Return to the Home Screen Music
    super.dispose();
  }

  // Automatically triggered when the application is minimized or returned to
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _pauseTimer(); // Pause when minimized or a call comes in
    } else if (state == AppLifecycleState.resumed) {
      if(!_isGameOver) _startTimer(); // Resume when returned to
    }
  }

  Future<void> _loadDictionary() async {
    try {
      //Reads the txt file
      final String dictionaryText = await rootBundle.loadString(
        'assets/texts/dictionary.txt',
      );

      // Splits each line, converts it to lowercase, and puts it into Set (Very fast)
      setState(() {
        _validWordsSet = dictionaryText
            .split('\n')
            .map((word) => word.trim().toLowerCase())
            .where((word) => word.isNotEmpty)
            .toSet();
        _isDictionaryLoaded = true;
      });
    } catch (e) {
      debugPrint("Error loading dictionary: $e");
    }
  }

  void _generateRandomLetters() {
    // A simple logic focused on vowels can be set up to increase the chances of an English word coming out,
    // For now, only 16 completely random letters from A-Z
    final random = Random();

    // Vowel pool
    final List<String> vowels = ['A', 'E', 'I', 'O', 'U'];

    // Consonant pool (weighted list adjusted according to English usage frequency)
    // S, T, R, N, L are critical for word generation, so their numbers are high
    final List<String> consonants = [
      'B', 'B', 'C', 'C', 'D', 'D', 'D', 'F', 'F', 'G', 'G', 'H', 'H', 'H',
      'J', 'K', 'L', 'L', 'L', 'L', 'M', 'M', 'N', 'N', 'N', 'N', 'N',
      'P', 'P', 'QU', 'R', 'R', 'R', 'R', 'R', 'S', 'S', 'S', 'S',
      'T', 'T', 'T', 'T', 'T', 'V', 'W', 'W', 'X', 'Y', 'Y', 'Z',
    ];

    List<String> selectedLetters = [];

    // 1. RULE: Select a random number of vowels between 4 and 8
    int vowelCount = 4 + random.nextInt(5);

    for (int i = 0; i < vowelCount; i++) {
      selectedLetters.add(vowels[random.nextInt(vowels.length)]);
    }

    // 2. RULE: Fill the remaining spaces with consonants (Total will be 16)
    int consonantCount = 16 - vowelCount;
    for (int i = 0; i < consonantCount; i++) {
      selectedLetters.add(consonants[random.nextInt(consonants.length)]);
    }

    // 3. RULE: Shuffle all letters thoroughly to randomly distribute them in the grid
    selectedLetters.shuffle(random);

    setState(() {
      _gridLetters = selectedLetters;
    });
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel existing one first to avoid collision
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        // Times's up!
        timer.cancel();
        setState(() {
          _isGameOver = true;
          _selectedIndices.clear();
        });
        _showGameOverDialog();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  // Helper method that converts seconds to 03:00 format
  String get _formattedTime {
    int minutes = _secondsLeft ~/ 60;
    int seconds = _secondsLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Combines the selected letters so far to show the word
  String get _currentWord {
    return _selectedIndices.map((index) => _gridLetters[index]).join('');
  }

  // Letter click event
  void _toggleLetter(int index) {
    if (_isGameOver) return; // Prevent clicking if time's up
    setState(() {
      if (_selectedIndices.contains(index)) {
        // Only allow the last selected letter to be undone (Game Rule)
        if (_selectedIndices.last == index) {
          _selectedIndices.removeLast();
        }
      } else {
        // Add if not selected
        _selectedIndices.add(index);
      }
    });
  }

  // --- WORD SUBMITTING AND SCORING LOGIC ---
  void _submitWord() {
    String word = _currentWord;

    if (word.length < 3) {
      _showSnackBar(
        AppLocalizations.of(context)!.wordTooShort,
        Colors.redAccent,
      );
      setState(() => _selectedIndices.clear());
      return;
    }

    // Has the word been found before?
    bool alreadyFound = _foundWords.any((item) => item['word'] == word);
    if (alreadyFound) {
      _showSnackBar(
        AppLocalizations.of(context)!.wordAlreadyFound,
        Colors.orangeAccent,
      );
      setState(() => _selectedIndices.clear());
      return;
    }

    // Dictionary Check
    bool isWordValid = _validWordsSet.contains(word.toLowerCase());

    if (isWordValid) {
      // Score Calculation: 3 letters=1, 4 letters=2, 5 letters=3...
      int pointsEarned = word.length - 2;

      setState(() {
        _score += pointsEarned;
        // We insert it at index 0 so that it is added to the top of the list
        _foundWords.insert(0, {'word': word, 'points': pointsEarned});
        _selectedIndices.clear();
      });

      _showSnackBar(
        AppLocalizations.of(context)!.pointsEarned(pointsEarned),
        AppColors.success ?? Colors.green,
      );
    } else {
      _showSnackBar(
        AppLocalizations.of(context)!.invalidWord,
        Colors.redAccent,
      );
      setState(() => _selectedIndices.clear());
    }
  }

  void _showSnackBar(String message, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center, // Centering the text always looks more modern
          style: const TextStyle(
            fontWeight: FontWeight.w700, // Bold. w700 is the most solid and ideal.
            color: Colors.white,
            fontSize: 16, // 1-2 clicks larger than the original, perfectly readable border
            letterSpacing: 0.5, // MAGIC TOUCH: Slight spacing between letters adds a very modern and fresh playful feel to the text.
          ),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,

        // TO MAKE IT APPEAR FROM THE TOP (We push it upwards, leaving a huge gap from the bottom of the screen)
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 160, // If it stays too high or too low on the screen, we can increase or decrease this 160 number a little
          left: 32,
          right: 32,
        ),

        // FOR A MORE MODERN DESIGN (Rounded edges and lightly shaded)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        elevation: 6, // That slight sense of depth (shadow) in modern applications
      ),
    );
  }

  Future<bool> _showExitConfirmDialog() async {
    _pauseTimer(); // 1. Stop the timer definitively when the dialog opens

    final result = await showDialog<bool>(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: surfaceColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.exitWordAlyxTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.exitWordAlyxDesc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          // ONLY THIS HAS CHANGED
                          // Closes the dialog and returns "false".
                          onPressed: () => Navigator.of(context).pop(false),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.cancel ?? 'Cancel',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.quit,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

    // 2. Restart the timer if the user clicks "Cancel" and returns to the game
    // Since it returns "Cancel" (false), this line will now run without problems and the timer will continue!
    if (result == false && !_isGameOver && mounted) {
      _startTimer();
    }

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // Exit if user confirms
        final shouldExit = await _showExitConfirmDialog();
        if (shouldExit && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'WORDALYX',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              fontSize: 24,
              shadows: [
                Shadow(color: primaryColor.withOpacity(0.5), blurRadius: 10),
              ],
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.white),
            onPressed: () async {
              // Show the same dialog when the cross button is pressed
              final shouldExit = await _showExitConfirmDialog();
              if (shouldExit && context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // 1. HEADER AREA (Duration and Score)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBadge(
                      Icons.timer_outlined,
                      _formattedTime,
                      _secondsLeft <= 10 ? Colors.redAccent : Colors.white,
                      isPulsing: _secondsLeft <= 10,
                    ),
                    _buildInfoBadge(
                      Icons.stars_rounded,
                      '$_score ${AppLocalizations.of(context)!.points}',
                      accentColor,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // 2. LIST OF FOUND WORDS (Referenced by British Council)
              Container(
                height: 110,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: surfaceColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: _foundWords.isEmpty
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.startFindingWords,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.3),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: _foundWords.length,
                        itemBuilder: (context, index) {
                          final item = _foundWords[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['word'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Text(
                                  '+${item['points']}',
                                  style: TextStyle(
                                    color: accentColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 15),

              // 3. THE CURRENT WORD AREA WRITTEN BY THE USER
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: primaryColor.withOpacity(0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _currentWord.isEmpty
                        ? AppLocalizations.of(context)!.createWord
                        : _currentWord,
                    style: TextStyle(
                      color: _currentWord.isEmpty
                          ? Colors.white38
                          : Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 4. 4x4 LETTER TABLE (GRIDVIEW)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GridView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // Turn off scrolling
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedIndices.contains(index);

                      return GestureDetector(
                        onTap: () => _toggleLetter(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : surfaceColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.white
                                  : primaryColor.withOpacity(0.2),
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.6),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              _gridLetters[index],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : primaryColor.withOpacity(0.9),
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // 5. ACTION BUTTONS (Clear and Send)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: _isGameOver
                            ? null
                            : () => setState(() => _selectedIndices.clear()),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Colors.white24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.clear,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _isGameOver ? null : _submitWord,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _isGameOver
                              ? AppLocalizations.of(context)!.timesUp
                              : AppLocalizations.of(context)!.submit,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Time and Score Container (Widget)
  Widget _buildInfoBadge(
    IconData icon,
    String text,
    Color color, {
    bool isPulsing = false,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isPulsing ? color.withOpacity(0.2) : surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: isPulsing ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _score = 0;
      _secondsLeft = 180;
      _isGameOver = false;
      _foundWords.clear();
      _selectedIndices.clear();
      _generateRandomLetters();
    });
    _startTimer();
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents the screen from being closed by clicking on it
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: primaryColor, width: 2),
              boxShadow: [
                BoxShadow(color: primaryColor.withOpacity(0.5), blurRadius: 20),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.gameOver,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.yourScore,
                  style: const TextStyle(color: Colors.white70, fontSize: 18),
                ),
                Text(
                  '$_score',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      _resetGame(); // Reset and restart the game
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.playAgain,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12), // Space between Play Again and Home
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.pop(context); // Close the WordAlyx screen and return to Home
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.white24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.backToHome,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
