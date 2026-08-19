// OLD Question Service - JSON Reader
/*
import 'dart:convert';
import 'package:flutter/services.dart';
import 'question_screen.dart'; // File where the Question model is located

class QuestionService {
  // List to keep all questions in memory
  static List<Question> _allQuestions = [];

  // This should be called at app startup (in main.dart or splash screen)
  static Future<void> loadQuestions() async {
    try {
      // 1. Read the JSON file as text
      final String response = await rootBundle.loadString('assets/questions.json');

      // 2. Convert the text into a List
      final List<dynamic> data = json.decode(response);

      // 3. Convert each item into a Question object
      _allQuestions = data.map((json) => Question.fromJson(json)).toList();

      print("Questions loaded. Total number of questions: ${_allQuestions.length}");
    } catch (e) {
      print("Error loading questions: $e");
    }
  }

  // Function to get questions by category and difficulty
  static List<Question> getQuestions({required String category, required String difficulty}) {
    List<Question> filtered = _allQuestions.where((q) => q.category == category).toList();

    // If difficulty is not 'Mixed', also filter by difficulty
    if (difficulty != 'Mixed') {
      filtered = filtered.where((q) => q.difficulty == difficulty).toList();
    }

    filtered.shuffle(); // Shuffle the questions
    return filtered;
  }

  // Get random questions for Endless mode
  static List<Question> getEndlessQuestions() {
    List<Question> all = List.from(_allQuestions);
    all.shuffle();
    return all;
  }
}
*/

// New Question Service
import 'package:cloud_firestore/cloud_firestore.dart';
import 'question_screen.dart'; // For the Question object
import 'dart:convert';
import 'package:flutter/services.dart';

class QuestionService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /*
  // Instead of the old getQuestions and loadQuestions, we now use this async method
  static Future<List<Question>> getOnlineQuestions({
    required String category,
    required String difficulty,
  }) async {
    try {
      // NOTE: For now, we are not applying category or difficulty filters!
      // We simply fetch everything inside the 'questions' collection in the database.
      Query query = _db.collection('questions');

      // Go to the database and download the questions
      final snapshot = await query.get();

      // Convert the fetched data into Question objects
      List<Question> questions = snapshot.docs.map((doc) {
        return Question.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      questions.shuffle(); // Shuffle the list
      return questions;

    } catch (e) {
      print("Firestore question fetch error: $e");
      return [];
    }
  }
  */

  // --- UPDATED getOnlineQuestions FUNCTION ---
  static Future<List<Question>> getOnlineQuestions({
    required String category,
    required String difficulty,
  }) async {
    try {
      Query query = _db.collection('questions');

      final String cat = category.toLowerCase();
      // If the category is "mixed", "all", "endless" or empty, DO NOT filter, pull the entire database!
      if (cat != 'mixed' && cat != 'all' && cat != 'endless' && cat.isNotEmpty) {
        query = query.where('category', isEqualTo: category);
      }

      final String diff = difficulty.toLowerCase();
      // DO NOT filter if difficulty is "mixed", "all" or empty
      if (diff != 'mixed' && diff != 'all' && diff.isNotEmpty) {
        query = query.where('difficulty', isEqualTo: difficulty);
      }

      // Capture questions with offline support
      final snapshot = await query.get(const GetOptions(source: Source.serverAndCache));

      List<Question> questions = snapshot.docs.map((doc) {
        return Question.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      questions.shuffle();
      return questions;
    } catch (e) {
      print("Firestore question fetch error: $e");
      return [];
    }
  }

  // --- GEÇİCİ VERİ TEMİZLEME (SANITIZATION) FONKSİYONU ---
  static Future<void> findAndLogDuplicateQuestions() async {
    print("Veritabanı taraması başlatılıyor...");
    final db = FirebaseFirestore.instance;

    try {
      final snapshot = await db.collection('questions').get();
      Map<String, List<QueryDocumentSnapshot>> questionMap = {};

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final questionText = data['question']?.toString().trim() ?? '';

        if (questionText.isNotEmpty) {
          if (!questionMap.containsKey(questionText)) {
            questionMap[questionText] = [];
          }
          questionMap[questionText]!.add(doc);
        }
      }

      int duplicateCount = 0;
      questionMap.forEach((questionText, docs) {
        if (docs.length > 1) {
          duplicateCount++;
          print("\n========================================");
          print("🚨 KOPYA SORU BULUNDU: $questionText");
          print("Kopya Sayısı: ${docs.length}");

          for (var i = 0; i < docs.length; i++) {
            final data = docs[i].data() as Map<String, dynamic>;
            final docId = docs[i].id;
            final answerIndex = data['answerIndex'];
            final options = data['options'] as List<dynamic>? ?? [];

            String correctAnswer = "Bilinmiyor";
            if (answerIndex != null && answerIndex >= 0 && answerIndex < options.length) {
              correctAnswer = options[answerIndex].toString();
            }

            print("  -> Döküman ID: $docId | İşaretli Doğru Cevap: $correctAnswer (Index: $answerIndex)");
          }
        }
      });

      print("\n========================================");
      print("Tarama Tamamlandı! Toplam $duplicateCount adet kopya/çelişkili soru grubu bulundu.");

    } catch (e) {
      print("Tarama sırasında hata oluştu: $e");
    }
  }
}