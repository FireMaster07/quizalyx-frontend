import 'dart:async';
// import 'dart:convert'; // Unused
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle; // Unused
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'main.dart';
import 'mission_manager.dart'; // Don’t forget the task manager
import 'question_service.dart'; // To fetch questions
import 'currency_manager.dart';
import 'audio_manager.dart';
import 'l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class Question {
  final int id;
  final String question;
  final List<String> options;
  final int answerIndex;
  final String category;
  final String difficulty;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.category,
    required this.difficulty,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      // If the id is accidentally a string or null in the source JSON, it safely converts it to an int.
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,

      // If the question text is missing, it prints a warning text instead of crashing.
      question: json['question']?.toString() ?? 'Question data could not be retrieved.',

      // If the options are missing/corrupted, it throws an empty list, it doesn't crash.
      options: json['options'] != null ? List<String>.from(json['options']) : ["A", "B", "C", "D"],

      // If the answerIndex is corrupted/string, it safely converts it to an int.
      answerIndex: json['answerIndex'] is int ? json['answerIndex'] : int.tryParse(json['answerIndex']?.toString() ?? '0') ?? 0,

      category: json['category']?.toString() ?? 'Mixed',
      difficulty: json['difficulty']?.toString() ?? 'Mixed',
    );
  }
}

class QuestionScreen extends StatefulWidget {
  final String mode;
  final String category;
  final String difficulty;

  const QuestionScreen({
    super.key,
    required this.mode,
    required this.category,
    required this.difficulty,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  List<Question> _allQuestions = [];
  List<Question> _activeQuestions = [];
  bool _isJsonLoaded = false;

  bool purpleTheme = true;
  bool showDifficulty = true;
  bool _revealed = false;
  bool _answered = false;
  bool _showResult = false;
  int _currentIndex = 0;
  int? _selectedOption;
  int _correctCount = 0;
  int _wrongCount = 0;

  // Timer variables
  Timer? _perQuestionTimer;
  int _perQuestionRemaining = 30;
  Timer? _globalTimer;
  int _globalRemaining = 180;

  // Music and Sound Management
  bool _isGamePaused = false; // To track whether the game is paused

  static const String _kEndlessHighScoreKey = 'endless_highscore';
  int _endlessHighScore = 0;
  int numberOfQuestions = 10;
  int timedDuration = 30;
  int endlessDuration = 180;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  // NEW VARIABLE TO BE ADDED:
  bool _isExitDialogVisible = false;

  // --- JOKER VARIABLES ---
  int _count5050 = 0; // Number of 50/50 in the bag
  int _countTime = 0; // Number of Time Jokers in the bag

  bool _is5050Used = false; // Was 50/50 used in this question?
  List<int> _hiddenOptions = []; // Indexes of the hidden options

  bool _isTimeFrozen = false; // Is time frozen?

  // --- NEW: FOR THE POINT SYSTEM ---
  int _sessionScore = 0;       // Total points earned in this round
  bool _showPlus10 = false;    // Should the "+10" text be shown?

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // We assume that the JSON is already loaded (because it was loaded in Main.dart)
    _isJsonLoaded = true;

    _loadHighScore();
    _loadUserSettings();
    _loadJokerCounts(); // Call this
  }

  // --- NEWLY ADDED FUNCTION ---
  Future<void> _saveSessionStats() async {
    final user = FirebaseAuth.instance.currentUser;

    // Check whether it's a guest or a real account
    final String prefix = user != null ? '${user.uid}_' : 'guest_';
    final prefs = await SharedPreferences.getInstance();

    // Stats earned in this session
    final int xpEarned = _sessionScore;
    final int answeredCorrectly = _correctCount;
    final int answeredTotal = _correctCount + _wrongCount;

    // Read previous data
    int totalXp = prefs.getInt('${prefix}total_xp') ?? 0;
    int quizzesPlayed = prefs.getInt('${prefix}quizzes_played') ?? 0;
    int correctAnswers = prefs.getInt('${prefix}correct_answers') ?? 0;
    int totalAnswers = prefs.getInt('${prefix}total_answers') ?? 0;

    int newTotalXp = totalXp + xpEarned; // Calculate the new total score

    // Add new data on top and save
    await prefs.setInt('${prefix}total_xp', newTotalXp + xpEarned);
    await prefs.setInt('${prefix}quizzes_played', quizzesPlayed + 1);
    await prefs.setInt('${prefix}correct_answers', correctAnswers + answeredCorrectly);
    await prefs.setInt('${prefix}total_answers', totalAnswers + answeredTotal);

    // CLOUD UPDATE (Synchronizing both Leaderboard and Users collections)
    if (user != null) {
      final db = FirebaseFirestore.instance;

      // 1. Leaderboard Update (For the table everyone sees)
      await db.collection('leaderboard').doc(user.uid).set({
        'score': newTotalXp,
      }, SetOptions(merge: true));

      // 2. User Profile Update (Added for My Statistics screen!)
      await db.collection('users').doc(user.uid).set({
        'totalXp': newTotalXp,
        'quizzesPlayed': quizzesPlayed + 1,
        'correctAnswers': correctAnswers + answeredCorrectly,
        'totalAnswers': totalAnswers + answeredTotal,
      }, SetOptions(merge: true));
    }
  }

  Future<void> _loadJokerCounts() async {
    final c50 = await CurrencyManager.getInventory('hint_5050');
    final cTime = await CurrencyManager.getInventory('time_freeze');
    if (mounted) {
      setState(() {
        _count5050 = c50;
        _countTime = cTime;
      });
    }
  }

  // Exit confirmation function
  Future<void> _handleExitQuiz() async {
    // Pause the music (When the dialog opens, it may continue playing in the background, but if exited it should stop)
    // You could stop it here if you want, but we already manage this via lifecycle.
    //
    // WARNING: Never write _pauseQuestionMusic() or similar code here.
    // The music must keep playing.
    //
    // 1. Mark that the dialog has been opened

    _isExitDialogVisible = true;

    final shouldQuit =
        await showDialog<bool>(
          context: context,
          // Do not close the dialog when tapping outside (optional, forces the user to make a clear choice)
          barrierDismissible: false,
          builder: (context) => Dialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.warning,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.quitQuizTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.quitQuizDesc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              Navigator.of(context).pop(false), // No, stay
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white24),
                          ),
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pop(true), // Yes, exit
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.warning,
                            foregroundColor: AppColors.background,
                          ),
                          child: Text(AppLocalizations.of(context)!.quit),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;

    // 2. Dialog closed, remove the indicator
    _isExitDialogVisible = false;

    if (shouldQuit) {
      AudioManager.instance.playHomeMusic();
      _perQuestionTimer?.cancel(); // Clean the timers
      _globalTimer?.cancel();

      // Instead of going to Topic Selection, go directly back to Home
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  // --- MUSIC AND LIFECYCLE MANAGEMENT (FIXED) ---
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Application minimized or returned to the home screen:
      // 1. PAUSE the music (not Stop)

      // 2. Freeze the timer (to keep it fair)
      _pauseTimers();

      setState(() {
        _isGamePaused = true;
      });
    } else if (state == AppLifecycleState.resumed) {
      // Application reopened:
      if (_revealed && !_showResult) {
        // If the game is not over, resume the music from where it left off

        // Continue the timer
        _resumeTimers();

        setState(() {
          _isGamePaused = false;
        });
      }
    }
    // Note: We deliberately ignore the 'inactive' state (when the notification panel is pulled down).
    // This way, the music does not stop when the panel is opened.
  }

  void _pauseTimers() {
    _perQuestionTimer?.cancel();
    _globalTimer?.cancel();
  }

  void _resumeTimers() {
    // Only if the game is active and the timers have previously been running, restart them
    if (widget.mode == 'timed') {
      _startPerQuestionTimer(resume: true);
    } else if (widget.mode == 'endless') {
      _startGlobalTimer(resume: true);
    }
  }

  // --------------------------------------------------

  Future<void> _loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      purpleTheme = prefs.getBool('purple_theme') ?? true;
      showDifficulty = prefs.getBool('show_difficulty') ?? true;
      numberOfQuestions = prefs.getInt('number_of_questions') ?? 10;
      timedDuration = prefs.getInt('timed_duration') ?? 30;
      endlessDuration = prefs.getInt('endless_duration') ?? 180;
    });
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _endlessHighScore = prefs.getInt(_kEndlessHighScoreKey) ?? 0;
    });
  }

  Future<void> _saveHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kEndlessHighScoreKey, score);
    setState(() {
      _endlessHighScore = score;
    });
  }

  // Loyalty to the old friend: We are commenting out the OLD _prepareQuestionsForMode function here
  /*
  void _prepareQuestionsForMode() {
    // 1. Request questions from the service
    // In Endless mode, difficulty does not matter; we request all of them ('Mixed').
    // In other modes, we request the selected difficulty.
    List<Question> fetchedQuestions = QuestionService.getQuestions(
      category: widget.category,
      difficulty: (widget.mode == 'endless') ? 'Mixed' : widget.difficulty,
    );

    // 2. Adjust the list according to the mode
    if (widget.mode == 'endless') {
      // Endless mode: No limit, add all incoming questions to the list
      _activeQuestions = fetchedQuestions;
    } else {
      // Classic/Timed mode: Take as many as 'numberOfQuestions' from the settings (e.g., 10 questions)
      // The min() function is for this: If the database has 8 questions but the user requested 10,
      // the application won’t crash; it will take 8 instead.
      int count = min(numberOfQuestions, fetchedQuestions.length);
      _activeQuestions = fetchedQuestions.take(count).toList();
    }

    // 3rd Security Measure (Logs output)
    if (_activeQuestions.isEmpty) {
      debugPrint("WARNING: No questions found in the ${widget.category} category!");
    }
  }
  */

  // NEW AND ASYNCHRONOUS _revealQuestion FUNCTION
  void _revealQuestion() async {
    if (!_isJsonLoaded) return;

    setState(() {
      _revealed = true;
      _showResult = false;
      _answered = false;
      _currentIndex = 0;

      _is5050Used = false;
      _hiddenOptions = [];

      // Does time freeze get canceled when moving to the next question? Generally yes:
      _isTimeFrozen = false;

      _selectedOption = null;
      _correctCount = 0;
      _wrongCount = 0;

      // NEW: We clear the list so that the "Loading" spinner (CircularProgressIndicator) shows on screen
      _activeQuestions = [];
    });

    // OLD-STYLE
    /*
    // _prepareQuestionsForMode();
    _playQuestionMusic();
    _slideController.forward();
     */

    // OLD-STYLE
    /*
    if (widget.mode == 'timed') {
      _startPerQuestionTimer();
    } else if (widget.mode == 'endless') {
      _startGlobalTimer();
    }
     */

    // 1. FETCH QUESTIONS FROM THE INTERNET (Instead of the commented-out _prepareQuestions, we now use this)
    List<Question> fetchedQuestions = await QuestionService.getOnlineQuestions(
      category: widget.category,
      difficulty: (widget.mode == 'endless') ? 'Mixed' : widget.difficulty,
    );

    // --- CRITICAL FIX HERE ---
    // If there is no internet and the cache is empty (first login, etc.), stop the function!
    if (fetchedQuestions.isEmpty) {
      if (mounted) {
        setState(() {
          _revealed = false; // Close the loading screen, return to the "Start
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.questionsLoadError),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      return; // PREVENTS IT FROM GOING DOWN (COUNTER NEVER STARTS!)
    }
    // --------------------------------

    // 2. ADJUST QUESTION COUNT BASED ON GAME MODE
    if (widget.mode == 'endless') {
      _activeQuestions = fetchedQuestions;
    } else {
      int count = min(numberOfQuestions, fetchedQuestions.length);
      _activeQuestions = fetchedQuestions.take(count).toList();
    }

    // 3. ACTIVATE UI AND START THE GAME
    if (mounted) {
      AudioManager.instance.playQuestionMusic(); // NOW CALLED FROM CENTRAL MANAGER
      setState(() {
        _slideController.forward();

        if (widget.mode == 'timed') {
          _startPerQuestionTimer();
        } else if (widget.mode == 'endless') {
          _startGlobalTimer();
        }
      });
    }
  }

  void _startPerQuestionTimer({bool resume = false}) {
    _perQuestionTimer?.cancel();
    if (!resume) {
      _perQuestionRemaining = timedDuration;
    }

    _perQuestionTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_perQuestionRemaining > 0) {
        setState(() => _perQuestionRemaining--);
      } else {
        t.cancel();
        _handleAutoWrongForTimed();
      }
    });
  }

  void _cancelPerQuestionTimer() {
    _perQuestionTimer?.cancel();
  }

  void _handleAutoWrongForTimed() {
    setState(() {
      _wrongCount++;
      _answered = true;
      _selectedOption = null;
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      _moveNextOrFinish();
    });
  }

  void _startGlobalTimer({bool resume = false}) {
    _globalTimer?.cancel();
    if (!resume) {
      _globalRemaining = endlessDuration;
    }

    _globalTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_globalRemaining > 0) {
        setState(() => _globalRemaining--);
      } else {
        t.cancel();
        _finishEndlessMode();
      }
    });
  }

  void _cancelGlobalTimer() {
    _globalTimer?.cancel();
  }

  void _finishEndlessMode() {
    _cancelGlobalTimer();
    AudioManager.instance.stopMusic();

    // If the current correct count beats the high score, save it
    if (_correctCount > _endlessHighScore) {
      _saveHighScore(_correctCount);
    }

    // Mission Progress Recording
    MissionManager.incrementProgress(context, widget.category, _correctCount);

    // NEWLY ADDED LINE: Save statistics to local storage
    _saveSessionStats();

    // Update UI state to show results
    setState(() {
      _showResult = true;
      _revealed = false;
    });

    // After a short delay, show end-of-quiz options
    Future.delayed(const Duration(milliseconds: 300), () {
      _showEndOfQuizOptions();
    });
  }

  void _selectOption(int index) {
    // 1. If already answered or no question exists, do nothing
    if (_answered || _activeQuestions.isEmpty) return;

    // 2. Stop timers
    if (widget.mode == 'timed') {
      _cancelPerQuestionTimer();
    }
    // In endless mode, it’s also good to stop the global timer if it exists
    if (widget.mode == 'endless') _globalTimer?.cancel();

    final q = _activeQuestions[_currentIndex];
    final correct = index == q.answerIndex;

    setState(() {
      _selectedOption = index;
      _answered = true;

      if (correct) {
        _correctCount++;

        // --- NEW: SCORE AND ANIMATION ---
        _sessionScore += 10; // Increase the score
        _showPlus10 = true;  // Show the "+10" text

        // --- NEW: MISSION PROGRESS (with Context) ---
        // Context is required for showing a notification when a coin reward or mission is completed
        MissionManager.incrementProgress(context, widget.category, 1);

      } else {
        _wrongCount++;
      }
    });

    // --- Sound Effects (if you have the function) ---
    // if (correct) _playSound('correct.mp3'); else _playSound('wrong.mp3');

    // --- Clear Animation ---
    if (correct) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) setState(() => _showPlus10 = false);
      });
    }

    // --- Move to Next Question ---
    // We wait 1.5 seconds so the user can see their score (quick but visible)
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _moveNextOrFinish();
      }
    });
  }

  void _moveNextOrFinish() {
    if (widget.mode == 'endless') {
      if ((_globalRemaining <= 0) || _activeQuestions.isEmpty) {
        _finishEndlessMode();
        return;
      }

      _slideController.reset();
      setState(() {
        _currentIndex = (_currentIndex + 1) % _activeQuestions.length;

        _is5050Used = false;
        _hiddenOptions = [];

        // Does time freeze get canceled when moving to the next question? Generally yes:
        _isTimeFrozen = false;

        _selectedOption = null;
        _answered = false;
      });
      _slideController.forward();
    } else {
      if (_currentIndex < _activeQuestions.length - 1) {
        _slideController.reset();
        setState(() {
          _currentIndex++;
          _selectedOption = null;
          _answered = false;
        });
        _slideController.forward();

        if (widget.mode == 'timed') _startPerQuestionTimer();
      } else {
        if (widget.mode == 'timed') _cancelPerQuestionTimer();
        AudioManager.instance.stopMusic();

        // Mission recording (Classic/Timed)
        MissionManager.incrementProgress(context, widget.category, _correctCount);

        // NEWLY ADDED LINE: Save statistics to local storage
        _saveSessionStats();

        // Update UI state to show results
        setState(() {
          _showResult = true;
          _revealed = false;
        });

        // After a short delay, show the score summary
        Future.delayed(const Duration(milliseconds: 300), () {
          _showScoreSummary();
        });
      }
    }
  }

  Color _getCategoryColor(String cat) {
    switch (cat.toLowerCase()) {
      case 'science':
        return const Color(0xFF06B6D4);
      case 'literature':
        return AppColors.primaryLight;
      case 'geography':
        return AppColors.accentOrange;
      case 'technology':
        return AppColors.accentBlue;
      case 'art':
        return AppColors.accentPink;
      case 'math':
        return const Color(0xFF14B8A6);
      case 'music':
        return const Color(0xFFFBBF24);
      case 'biology':
        return const Color(0xFF84CC16);
      case 'history':
        return const Color(0xFFF59E0B);
      case 'physics':
        return const Color(0xFF6366F1);
      case 'chemistry':
        return const Color(0xFFEC4899);
      case 'religion':
        return const Color(0xFFA855F7);
      case 'mechanic':
        return const Color(0xFF64748B);
      case 'software':
        return const Color(0xFF10B981);
      case 'sports':
        return const Color(0xFFF97316);
      default:
        return AppColors.textSecondary;
    }
  }

  Color _getDifficultyColor(String diff) {
    switch (diff.toLowerCase()) {
      case 'easy':
        return AppColors.success;
      case 'medium':
        return AppColors.warning;
      case 'hard':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  void dispose() {
    _perQuestionTimer?.cancel();
    _globalTimer?.cancel();
    _slideController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // --- 50/50 JOKER ---
  void _use5050Joker() async {
    // 1. If the count is 0, show a warning and exit
    if (_count5050 <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.no5050JokerWarning),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }

    // 2. If it’s already used, do nothing
    if (_is5050Used || _activeQuestions.isEmpty) return;

    // 3. Usage logic
    await CurrencyManager.useItem('hint_5050');
    setState(() {
      _count5050--;
      _is5050Used = true;
    });

    final q = _activeQuestions[_currentIndex];
    List<int> wrongIndices = [];
    for (int i = 0; i < q.options.length; i++) {
      if (i != q.answerIndex) wrongIndices.add(i);
    }
    wrongIndices.shuffle();

    setState(() {
      _hiddenOptions = wrongIndices.take(2).toList();
    });
  }

// --- TIME JOKER ---
  void _useTimeFreezeJoker() async {
    if (widget.mode == 'classic') return;

    // 1. If the count is 0, show a warning
    if (_countTime <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.noTimeFreezeWarning),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }

    // 2. If it’s already frozen, do nothing
    if (_isTimeFrozen) return;

    await CurrencyManager.useItem('time_freeze');
    setState(() {
      _countTime--;
      _isTimeFrozen = true;
    });

    // Stop the timer depending on the mode
    if (widget.mode == 'timed') {
      _perQuestionTimer?.cancel();
    } else if (widget.mode == 'endless') {
      _globalTimer?.cancel();
    }

    // Wait 10 seconds, then resume
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && !_showResult && !_answered) {
        setState(() => _isTimeFrozen = false);
        if (widget.mode == 'timed') {
          _startPerQuestionTimer(resume: true);
        } else if (widget.mode == 'endless') {
          _startGlobalTimer(resume: true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _handleExitQuiz();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        // NOTE: We REMOVED the standard AppBar.
        // Because we will use our own custom design.

        body: SafeArea(
          child: Column(
            children: [
              // --- 1. NEW HEADER (Score and Mode indicator you wanted) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BACK BUTTON
                    // (If you don’t have the _buildNeumorphicButton function, I put a normal IconButton here)
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.close_rounded, color: Colors.white),
                        onPressed: _handleExitQuiz, // Linked the exit function
                      ),
                    ),

                    // RIGHT SIDE: MODE AND SCORE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end, // Align to the right
                      children: [
                        // MODE BADGE
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.flash_on_rounded, color: AppColors.accentOrange, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                _getModeTitle(context).toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8), // Spacing

                        // SCORE INDICATOR (Animated)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // +10 Animation
                            AnimatedOpacity(
                              opacity: _showPlus10 ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                "+10",
                                style: TextStyle(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Score Box
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _showPlus10 ? AppColors.success : Colors.white10,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.stars_rounded, color: AppColors.accentBlue, size: 18),
                                  const SizedBox(width: 6),
                                  Text(
                                    '$_sessionScore', // Your score variable
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // --- 2. GAME AREA (Expanded fills the remaining space) ---
              Expanded(
                child: _revealed
                    ? _activeQuestions.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : _buildQuestionView(_activeQuestions[_currentIndex])
                    : _showResult
                    ? _buildResultView()
                    : Center(
                  child: ElevatedButton.icon(
                    key: const ValueKey('start_game_button'),
                    onPressed: _revealQuestion,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: Text(AppLocalizations.of(context)!.startQuiz),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                        vertical: AppSpacing.lg,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getModeTitle(BuildContext context) {
    switch (widget.mode) {
      case 'classic':
        return AppLocalizations.of(context)!.modeClassic;
      case 'timed':
        return AppLocalizations.of(context)!.modeTimed;
      case 'endless':
        return AppLocalizations.of(context)!.modeEndless;
      default:
        return AppLocalizations.of(context)!.quiz;
    }
  }

  Widget _buildJokerButton({
    required IconData icon,
    required int count,
    required bool isUsed, // Was it used in this question?
    required Color color,
    required VoidCallback onTap,
  }) {
    // Only disable the button if it was used in this question.
    // Even if the count is 0, keep it active so we can show "None" when pressed.
    bool isDisabled = isUsed;

    // For appearance: if the count is 0, make the color faded but still clickable.
    bool isEmpty = count <= 0;

    return GestureDetector(
      onTap: isDisabled ? null : onTap, // If disabled, it cannot be pressed
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              // If empty or already used, make it greyed out
              color: (isDisabled || isEmpty) ? Colors.grey.withOpacity(0.2) : color.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: (isDisabled || isEmpty) ? Colors.grey : color,
                width: 2,
              ),
              boxShadow: (isDisabled || isEmpty) ? [] : [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Icon(
              icon,
              color: (isDisabled || isEmpty) ? Colors.grey : color,
              size: 28,
            ),
          ),
          if (count > 0)
            Positioned(
              right: -5,
              top: -5,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                child: Center(
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuestionView(Question q) {
    final progress = (_currentIndex + 1) / _activeQuestions.length;

    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            if (widget.mode != 'endless') _buildProgressBar(progress),
            const SizedBox(height: AppSpacing.lg),
            _buildTimerWidget(),
            const SizedBox(height: AppSpacing.lg),
            _buildQuestionCard(q),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: ListView.builder(
                itemCount: q.options.length,
                itemBuilder: (context, index) => _buildOptionCard(q, index),
              ),
            ),

            const SizedBox(height: 16),

            // --- JOKER BUTTONS ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 50/50 Button
                _buildJokerButton(
                  icon: Icons.lightbulb_rounded,
                  count: _count5050,
                  isUsed: _is5050Used,
                  color: AppColors.accentOrange,
                  onTap: _use5050Joker,
                ),
                const SizedBox(width: 20),
                // Time Button
                if (widget.mode != 'classic') // No time in classic mode
                  _buildJokerButton(
                    icon: Icons.timer_off_rounded,
                    count: _countTime,
                    isUsed: _isTimeFrozen, // Disabled if frozen
                    color: AppColors.accentBlue,
                    onTap: _useTimeFreezeJoker,
                  ),
              ],
            ),
            const SizedBox(height: 16),

            _buildMetadata(q),
            const SizedBox(height: AppSpacing.md),
            _buildQuestionCounter(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryLight],
            ),
            borderRadius: BorderRadius.circular(AppRadius.full),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerWidget() {
    if (widget.mode == 'timed') {
      final isUrgent = _perQuestionRemaining <= 5;
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isUrgent
              ? AppColors.error.withOpacity(0.2)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: isUrgent ? AppColors.error : AppColors.warning,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timer_rounded,
              color: isUrgent ? AppColors.error : AppColors.warning,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '$_perQuestionRemaining s',
              style: TextStyle(
                color: isUrgent ? AppColors.error : AppColors.warning,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else if (widget.mode == 'endless') {
      final isUrgent = _globalRemaining <= 10;
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isUrgent
              ? AppColors.error.withOpacity(0.2)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: isUrgent ? AppColors.error : AppColors.accentBlue,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.all_inclusive_rounded,
              color: isUrgent ? AppColors.error : AppColors.accentBlue,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)!.timeSeconds(_globalRemaining),
              style: TextStyle(
                color: isUrgent ? AppColors.error : AppColors.accentBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildQuestionCard(Question q) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: purpleTheme
              ? [
                  AppColors.primary.withOpacity(0.2),
                  AppColors.primaryDark.withOpacity(0.1),
                ]
              : [AppColors.surface, AppColors.surfaceLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: purpleTheme
              ? AppColors.primary.withOpacity(0.3)
              : AppColors.surfaceLight,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        q.question,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildOptionCard(Question q, int index) {
    final isSelected = _selectedOption == index;
    final isCorrect = index == q.answerIndex;
    final showResult = _answered;

    Color backgroundColor;
    Color borderColor;
    IconData? icon;

    // --- NEW: If this option is eliminated, don’t show it ---
    if (_hiddenOptions.contains(index)) {
      return const SizedBox(height: 16); // Leave empty space so layout doesn’t shift
    }

    if (!showResult) {
      backgroundColor = AppColors.surfaceLight;
      borderColor = AppColors.surfaceLight;
    } else if (isCorrect) {
      backgroundColor = AppColors.success.withOpacity(0.2);
      borderColor = AppColors.success;
      icon = Icons.check_circle_rounded;
    } else if (isSelected && !isCorrect) {
      backgroundColor = AppColors.error.withOpacity(0.2);
      borderColor = AppColors.error;
      icon = Icons.cancel_rounded;
    } else {
      backgroundColor = AppColors.surfaceLight.withOpacity(0.3);
      borderColor = AppColors.surfaceLight.withOpacity(0.3);
    }

    return GestureDetector(
      key: ValueKey('option_${index}_button'),
      onTap: () => _selectOption(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: showResult
                    ? (isCorrect
                          ? AppColors.success
                          : isSelected
                          ? AppColors.error
                          : Colors.transparent)
                    : AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Center(
                child: icon != null
                    ? Icon(icon, color: Colors.white, size: 20)
                    : Text(
                        String.fromCharCode(65 + index),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                q.options[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadata(Question q) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.center,
      children: [
        _buildBadge(
          label: q.category,
          color: _getCategoryColor(q.category),
          icon: Icons.category_rounded,
        ),
        if (showDifficulty)
          _buildBadge(
            label: q.difficulty,
            color: _getDifficultyColor(q.difficulty),
            icon: Icons.star_rounded,
          ),
      ],
    );
  }

  Widget _buildBadge({
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCounter() {
    if (widget.mode != 'endless') {
      return Text(
        AppLocalizations.of(context)!.questionCounter(_currentIndex + 1, _activeQuestions.length),
        style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: AppColors.success, size: 18),
          const SizedBox(width: 6),
          Text(
            '$_correctCount',
            style: TextStyle(
              color: AppColors.success,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Icon(Icons.cancel, color: AppColors.error, size: 18),
          const SizedBox(width: 6),
          Text(
            '$_wrongCount',
            style: TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      );
    }
  }

  void _showScoreSummary() {
    final totalAnswered = _correctCount + _wrongCount;
    final percent = totalAnswered == 0
        ? 0
        : ((_correctCount / totalAnswered) * 100).round();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.emoji_events_rounded,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  AppLocalizations.of(context)!.quizCompleted,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildScoreRow(AppLocalizations.of(context)!.correct, '$_correctCount', AppColors.success),
                _buildScoreRow(AppLocalizations.of(context)!.wrong, '$_wrongCount', AppColors.error),
                _buildScoreRow(
                    AppLocalizations.of(context)!.score,
                    NumberFormat.percentPattern(Localizations.localeOf(context).languageCode).format(percent / 100),
                    AppColors.warning
                ),
                const SizedBox(height: AppSpacing.xl),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showEndOfQuizOptions();
                  },
                  child: Text(AppLocalizations.of(context)!.continueBtn),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScoreRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showEndOfQuizOptions() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.whatsNext,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _revealQuestion();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(AppLocalizations.of(context)!.playAgain),
                ),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    AudioManager.instance.playHomeMusic(); // HOME MUSIC STARTS ONLY HERE!
                    // --- FIX HERE ---
                    // Instead of just going back one step (pop),
                    // go all the way back to the Home Screen.
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(AppLocalizations.of(context)!.backToHome),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultView() {
    // Let’s set the default message to "Quiz Completed!"
    String message = AppLocalizations.of(context)!.quizCompleted;

    // Only in ENDLESS mode and if the TIME has run out, display "Time's Up!"
    if (widget.mode == 'endless' && _globalRemaining <= 0) {
      message = AppLocalizations.of(context)!.timesUp;
    }

    return Center(
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold, // I added a bit of thickness to make it look stylish
        ),
      ),
    );
  }
}
