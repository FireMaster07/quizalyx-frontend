import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// Question model
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
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<Question> _questions = [];
  bool _isJsonLoaded = false;
  bool _revealed = false;
  int _currentIndex = 0;
  int? _selectedOption;
  bool _answered = false;
  int _correctCount = 0;
  int _wrongCount = 0;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _loadQuestionsFromAsset();
  }

  Future<void> _loadQuestionsFromAsset() async {
    try {
      final raw = await rootBundle.loadString('assets/questions.json');
      final List<dynamic> data = json.decode(raw);
      final loaded =
      data.map((e) => Question.fromJson(e as Map<String, dynamic>)).toList();
      setState(() {
        _questions = loaded;
        _isJsonLoaded = true;
      });
    } catch (e) {
      debugPrint('Failed to load questions.json: $e');
    }
  }

  void _revealQuestion() {
    if (!_isJsonLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Questions are still loading...')),
      );
      return;
    }
    setState(() {
      _revealed = true;
      _answered = false;
      _selectedOption = null;
      _currentIndex = 0;
      _correctCount = 0;
      _wrongCount = 0;
      _showResult = false;
    });
  }

  void _selectOption(int index) {
    if (_answered) return; // prevent multiple answers

    final currentQuestion = _questions[_currentIndex];
    setState(() {
      _selectedOption = index;
      _answered = true;
      if (index == currentQuestion.answerIndex) {
        _correctCount++;
      } else {
        _wrongCount++;
      }
    });

    // If it's the last question, show results
    if (_currentIndex == _questions.length - 1) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _showResult = true;
        });
      });
    }
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _answered = false;
      });
    }
  }

  Color _getOptionColor(Question q, int index) {
    if (!_answered) return Colors.grey[850]!;

    if (index == q.answerIndex) return Colors.green;
    if (index == _selectedOption && _selectedOption != q.answerIndex) {
      return Colors.red;
    }
    return Colors.grey[850]!;
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
        for (int i = 0; i < 4; i++) ...[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            height: 54,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildQuestionView(Question q) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            q.question,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        const SizedBox(height: 24),
        for (int i = 0; i < q.options.length; i++) ...[
          GestureDetector(
            onTap: () => _selectOption(i),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: _getOptionColor(q, i),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade700),
              ),
              child: Row(
                children: [
                  Text(
                    '${String.fromCharCode(65 + i)}. ',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      q.options[i],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 18),
        Text(
          'Category: ${q.category}    Difficulty: ${q.difficulty}',
          style: const TextStyle(color: Colors.white60, fontSize: 12),
        ),
        const SizedBox(height: 24),
        if (_answered && _currentIndex < _questions.length - 1)
          ElevatedButton(
            onPressed: _nextQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent.shade400,
              foregroundColor: Colors.indigo,
            ),
            child: const Text('Next'),
          ),
      ],
    );
  }

  Widget _buildResultView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Quiz Completed!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Correct Answers: $_correctCount',
            style: const TextStyle(color: Colors.green, fontSize: 22),
          ),
          const SizedBox(height: 12),
          Text(
            'Wrong Answers: $_wrongCount',
            style: const TextStyle(color: Colors.red, fontSize: 22),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _revealQuestion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent.shade400,
              foregroundColor: Colors.indigo,
              padding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            ),
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasQuestions = _isJsonLoaded && _questions.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('QUIZALYX'),
      ),
      body: SafeArea(
        child: _showResult
            ? _buildResultView()
            : Column(
          children: [
            Expanded(
              child: Center(
                child: !_revealed
                    ? _buildPlaceholders()
                    : (hasQuestions
                    ? _buildQuestionView(
                    _questions[_currentIndex])
                    : _buildPlaceholders()),
              ),
            ),
            if (!_revealed)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 18),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent.shade400,
                    foregroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 16),
                  ),
                  onPressed: _revealQuestion,
                  child: const Text('Reveal Question'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
