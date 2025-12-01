import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

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
  final String mode; // 'classic', 'timed', 'endless'

  const QuestionScreen({super.key, required this.mode});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> with WidgetsBindingObserver {
  List<Question> _allQuestions = [];
  List<Question> _activeQuestions = [];
  bool _isJsonLoaded = false;

  // UI / state
  bool purpleTheme = true;
  bool showDifficulty = true;
  bool _revealed = false;
  bool _answered = false;
  bool _showResult = false;
  int _currentIndex = 0;
  int? _selectedOption;
  int _correctCount = 0;
  int _wrongCount = 0;

  // timers
  Timer? _perQuestionTimer;
  int _perQuestionRemaining = 30;

  Timer? _globalTimer;
  int _globalRemaining = 180; // used for endless mode

  // high score storage key
  static const String _kEndlessHighScoreKey = 'endless_highscore';
  int _endlessHighScore = 0;
  int numberOfQuestions = 10;
  int timedDuration = 30;
  int endlessDuration = 180;

  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _audioPlayer = AudioPlayer();
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
      picked.sort(
              (a, b) => _difficultyRank(a.difficulty).compareTo(_difficultyRank(b.difficulty)));
      _activeQuestions = picked;
    }
  }

  void _revealQuestion() {
    if (!_isJsonLoaded) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Questions not loaded yet.')));
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
    final scorePercent =
    totalAnswered == 0 ? 0 : ((_correctCount / totalAnswered) * 100).round();

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

    Future.delayed(const Duration(milliseconds: 800), () {
      _moveNextOrFinish();
    });
  }

  void _moveNextOrFinish() {
    if (widget.mode == 'endless') {
      if ((_globalRemaining <= 0) || _activeQuestions.isEmpty) {
        _finishEndlessMode();
        return;
      }

      setState(() {
        _currentIndex = (_currentIndex + 1) % _activeQuestions.length;
        _selectedOption = null;
        _answered = false;
      });
    } else {
      if (_currentIndex < _activeQuestions.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedOption = null;
          _answered = false;
        });

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
    if (!_answered) return Colors.grey[850]!;
    if (index == q.answerIndex) return Colors.green;
    if (index == _selectedOption && index != q.answerIndex) return Colors.red;
    return Colors.grey[850]!;
  }

  Color _getDifficultyColor(String diff) {
    switch (diff.toLowerCase()) {
      case 'easy':
        return Colors.greenAccent;
      case 'medium':
        return Colors.yellowAccent.shade700;
      case 'hard':
        return Colors.redAccent;
      default:
        return Colors.white70;
    }
  }

  Color _getCategoryColor(String cat) {
    switch (cat.toLowerCase()) {
      case 'science':
        return Colors.cyanAccent;
      case 'literature':
        return Colors.purpleAccent;
      case 'geography':
        return Colors.orangeAccent;
      case 'technology':
        return Colors.blueAccent;
      case 'art':
        return Colors.pinkAccent;
      case 'math':
        return Colors.tealAccent;
      case 'music':
        return Colors.amberAccent;
      case 'biology':
        return Colors.lightGreenAccent;
      default:
        return Colors.white70;
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget _buildPlaceholders() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 24),
        for (int i = 0; i < 4; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            height: 54,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
      ],
    );
  }

  Widget _buildQuestionView(Question q) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.mode == 'timed')
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Time Left: $_perQuestionRemaining s',
              style: TextStyle(
                color: _perQuestionRemaining <= 5 ? Colors.redAccent : Colors.cyanAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (widget.mode == 'endless')
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Time Left (Endless): $_globalRemaining s',
              style: TextStyle(
                color: _globalRemaining <= 10 ? Colors.redAccent : Colors.cyanAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: purpleTheme ? Colors.deepPurple : Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(q.question,
              style: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
        const SizedBox(height: 24),
        for (int i = 0; i < q.options.length; i++)
          GestureDetector(
            onTap: () => _selectOption(i),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: _getOptionColor(q, i),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade700),
              ),
              child: Row(
                children: [
                  Text('${String.fromCharCode(65 + i)}. ',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Expanded(
                      child: Text(q.options[i],
                          style: const TextStyle(color: Colors.white))),
                ],
              ),
            ),
          ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Category: ',
                style: TextStyle(color: Colors.white70, fontSize: 13)),
            Text(q.category,
                style: TextStyle(
                    color: _getCategoryColor(q.category), fontWeight: FontWeight.bold)),
            if (showDifficulty) ...[
              const SizedBox(width: 18),
              const Text('Difficulty: ',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
              Text(q.difficulty,
                  style: TextStyle(
                      color: _getDifficultyColor(q.difficulty),
                      fontWeight: FontWeight.bold)),
            ],
          ],
        ),
        const SizedBox(height: 20),
        if (widget.mode != 'endless')
          Text('Question ${_currentIndex + 1} / ${_activeQuestions.length}',
              style: const TextStyle(color: Colors.white54)),
        if (widget.mode == 'endless')
          Text('Correct: $_correctCount Wrong: $_wrongCount',
              style: const TextStyle(color: Colors.white54)),
      ],
    );
  }

  void _showScoreSummary() {
    final totalAnswered = _correctCount + _wrongCount;
    final percent =
    totalAnswered == 0 ? 0 : ((_correctCount / totalAnswered) * 100).round();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: const Text(
            'Your Score',
            style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Correct Answers: $_correctCount',
                  style: const TextStyle(color: Colors.greenAccent, fontSize: 18)),
              const SizedBox(height: 8),
              Text('Wrong Answers: $_wrongCount',
                  style: const TextStyle(color: Colors.redAccent, fontSize: 18)),
              const SizedBox(height: 8),
              Text('Score: $percent%',
                  style: const TextStyle(color: Colors.amberAccent, fontSize: 18)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showEndOfQuizOptions();
              },
              child: const Text('OK', style: TextStyle(color: Colors.cyanAccent)),
            ),
          ],
        );
      },
    );
  }

  void _showEndOfQuizOptions() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Finished!'),
          content: const Text('What do you want to do next?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _revealQuestion();
              },
              child: const Text('Play Again (Same Mode)'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Back to Home'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultView() {
    if (widget.mode == 'endless') {
      final totalAnswered = _correctCount + _wrongCount;
      final percent = totalAnswered == 0 ? 0 : ((_correctCount / totalAnswered) * 100).round();

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Time\'s up!',
                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 18),
            Text('Correct: $_correctCount', style: const TextStyle(color: Colors.greenAccent, fontSize: 18)),
            Text('Wrong: $_wrongCount', style: const TextStyle(color: Colors.redAccent, fontSize: 18)),
            Text('Score: $percent%', style: const TextStyle(color: Colors.amberAccent, fontSize: 18)),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _revealed
            ? _activeQuestions.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : _buildQuestionView(_activeQuestions[_currentIndex])
            : _showResult
            ? _buildResultView()
            : Center(
          child: ElevatedButton(
            onPressed: _revealQuestion,
            child: const Text('Reveal Questions'),
          ),
        ),
      ),
    );
  }
}
