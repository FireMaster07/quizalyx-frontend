import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'main.dart';

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
      id: json['id'] as int,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List<dynamic>),
      answerIndex: json['answerIndex'] as int,
      category: json['category'] as String? ?? '',
      difficulty: json['difficulty'] as String? ?? '',
    );
  }
}

class QuestionScreen extends StatefulWidget {
  final String mode;

  const QuestionScreen({super.key, required this.mode});

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

  Timer? _perQuestionTimer;
  int _perQuestionRemaining = 30;
  Timer? _globalTimer;
  int _globalRemaining = 180;

  static const String _kEndlessHighScoreKey = 'endless_highscore';
  int _endlessHighScore = 0;
  int numberOfQuestions = 10;
  int timedDuration = 30;
  int endlessDuration = 180;

  late AudioPlayer _audioPlayer;
  late AnimationController _slideController;
  late AnimationController _progressController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _audioPlayer = AudioPlayer();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _loadQuestions();
    _loadHighScore();
    _loadUserSettings();
  }

  Future<void> _playQuestionMusic() async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.play(
        AssetSource('audio/quiz-background-loop-thinking-news-275636.mp3'),
      );
    } catch (e) {
      debugPrint('Error playing question music: $e');
    }
  }

  Future<void> _stopQuestionMusic() async {
    await _audioPlayer.stop();
  }

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

  Future<void> _loadQuestions() async {
    try {
      final raw = await rootBundle.loadString('assets/questions.json');
      final List<dynamic> jsonList = json.decode(raw);
      final loaded = jsonList
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList();
      setState(() {
        _allQuestions = loaded;
        _isJsonLoaded = true;
      });
    } catch (e) {
      debugPrint('Failed to load questions.json: $e');
      setState(() {
        _isJsonLoaded = false;
      });
    }
  }

  int _difficultyRank(String s) {
    switch (s.toLowerCase()) {
      case 'easy':
        return 0;
      case 'medium':
        return 1;
      case 'hard':
        return 2;
      default:
        return 1;
    }
  }

  void _prepareQuestionsForMode() {
    if (!_isJsonLoaded) return;
    final random = Random();

    if (widget.mode == 'endless') {
      _activeQuestions = List<Question>.from(_allQuestions)..shuffle(random);
    } else {
      final total = _allQuestions.length;
      final needed = min(numberOfQuestions, total);
      final indices = <int>{};
      while (indices.length < needed) {
        indices.add(random.nextInt(total));
      }
      final picked = indices.map((i) => _allQuestions[i]).toList();
      picked.sort((a, b) =>
          _difficultyRank(a.difficulty).compareTo(_difficultyRank(b.difficulty)));
      _activeQuestions = picked;
    }
  }

  void _revealQuestion() {
    if (!_isJsonLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Questions not loaded yet.')),
      );
      return;
    }

    setState(() {
      _revealed = true;
      _showResult = false;
      _answered = false;
      _currentIndex = 0;
      _selectedOption = null;
      _correctCount = 0;
      _wrongCount = 0;
    });

    _prepareQuestionsForMode();
    _playQuestionMusic();
    _slideController.forward();

    if (widget.mode == 'timed') {
      _startPerQuestionTimer();
    } else if (widget.mode == 'endless') {
      _startGlobalTimer();
    }
  }

  void _startPerQuestionTimer() {
    _perQuestionTimer?.cancel();
    _perQuestionRemaining = timedDuration;
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
    _perQuestionRemaining = 30;
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

  void _startGlobalTimer() {
    _globalTimer?.cancel();
    _globalRemaining = endlessDuration;

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
    _globalRemaining = 180;
  }

  void _finishEndlessMode() {
    final totalAnswered = _correctCount + _wrongCount;
    if (_correctCount > _endlessHighScore) {
      _saveHighScore(_correctCount);
    }

    setState(() {
      _showResult = true;
      _revealed = false;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      _showEndOfQuizOptions();
    });
  }

  void _selectOption(int index) {
    if (_answered || _activeQuestions.isEmpty) return;

    final q = _activeQuestions[_currentIndex];
    final correct = index == q.answerIndex;

    setState(() {
      _selectedOption = index;
      _answered = true;
      if (correct) {
        _correctCount++;
      } else {
        _wrongCount++;
      }
    });

    if (widget.mode == 'timed') _cancelPerQuestionTimer();

    Future.delayed(const Duration(milliseconds: 1000), () {
      _moveNextOrFinish();
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

        setState(() {
          _showResult = true;
          _revealed = false;
        });

        Future.delayed(const Duration(milliseconds: 300), () {
          _showScoreSummary();
        });
      }
    }
  }

  Color _getOptionColor(Question q, int index) {
    if (!_answered) return AppColors.surfaceLight;
    if (index == q.answerIndex) return AppColors.success;
    if (index == _selectedOption && index != q.answerIndex) {
      return AppColors.error;
    }
    return AppColors.surfaceLight;
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
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _stopQuestionMusic();
    } else if (state == AppLifecycleState.resumed && _revealed && !_showResult) {
      _playQuestionMusic();
    }
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    _perQuestionTimer?.cancel();
    _globalTimer?.cancel();
    _slideController.dispose();
    _progressController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Suite dans la partie 2...
  // Suite de question_screen.dart (Partie 2/2)
// Collez ce code après le dispose() de la partie 1
  Widget _buildQuestionView(Question q) {
    final progress = (_currentIndex + 1) / _activeQuestions.length;

    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            // Progress bar
            if (widget.mode != 'endless') _buildProgressBar(progress),
            const SizedBox(height: AppSpacing.lg),

            // Timer
            _buildTimerWidget(),
            const SizedBox(height: AppSpacing.lg),

            // Question card
            _buildQuestionCard(q),
            const SizedBox(height: AppSpacing.lg),

            // Options
            Expanded(
              child: ListView.builder(
                itemCount: q.options.length,
                itemBuilder: (context, index) => _buildOptionCard(q, index),
              ),
            ),

            // Metadata
            _buildMetadata(q),
            const SizedBox(height: AppSpacing.md),

            // Question counter
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
              'Time Left: $_globalRemaining s',
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
              : [
                  AppColors.surface,
                  AppColors.surfaceLight,
                ],
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
      onTap: () => _selectOption(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: showResult && (isCorrect || isSelected)
              ? [
                  BoxShadow(
                    color: borderColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
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
                        style: TextStyle(
                          color: showResult && (isCorrect || isSelected)
                              ? Colors.white
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
        'Question ${_currentIndex + 1} / ${_activeQuestions.length}',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
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
    final percent =
        totalAnswered == 0 ? 0 : ((_correctCount / totalAnswered) * 100).round();

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
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryLight],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const Text(
                  'Quiz Completed!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildScoreRow(
                    'Correct', _correctCount.toString(), AppColors.success),
                const SizedBox(height: AppSpacing.sm),
                _buildScoreRow(
                    'Wrong', _wrongCount.toString(), AppColors.error),
                const SizedBox(height: AppSpacing.sm),
                _buildScoreRow('Score', '$percent%', AppColors.warning),
                const SizedBox(height: AppSpacing.xl),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showEndOfQuizOptions();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScoreRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
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
                const Text(
                  'What\'s Next?',
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: const Text('Play Again'),
                ),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: BorderSide(color: AppColors.textSecondary),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultView() {
    if (widget.mode == 'endless') {
      final totalAnswered = _correctCount + _wrongCount;
      final percent =
          totalAnswered == 0 ? 0 : ((_correctCount / totalAnswered) * 100).round();

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.timer_off_rounded,
                size: 80,
                color: AppColors.error,
              ),
              const SizedBox(height: AppSpacing.xl),
              const Text(
                'Time\'s Up!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _buildScoreRow('Correct', '$_correctCount', AppColors.success),
              const SizedBox(height: AppSpacing.md),
              _buildScoreRow('Wrong', '$_wrongCount', AppColors.error),
              const SizedBox(height: AppSpacing.md),
              _buildScoreRow('Score', '$percent%', AppColors.warning),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(_getModeTitle()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: _revealed
            ? _activeQuestions.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : _buildQuestionView(_activeQuestions[_currentIndex])
            : _showResult
                ? _buildResultView()
                : Center(
                    child: ElevatedButton.icon(
                      onPressed: _revealQuestion,
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Start Quiz'),
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
    );
  }

  String _getModeTitle() {
    switch (widget.mode) {
      case 'classic':
        return 'Classic Mode';
      case 'timed':
        return 'Timed Mode';
      case 'endless':
        return 'Endless Mode';
      default:
        return 'Quiz';
    }
  }
}