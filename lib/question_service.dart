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

  static Future<List<Question>> getOnlineQuestions({
    required String category,
    required String difficulty,
  }) async {
    try {
      Query query = _db.collection('questions');

      // If category is not "mixed", filter by category
      if (category.toLowerCase() != 'mixed') {
        query = query.where('category', isEqualTo: category);
      }

      // If difficulty is not "mixed", filter by difficulty
      if (difficulty.toLowerCase() != 'mixed') {
        query = query.where('difficulty', isEqualTo: difficulty);
      }

      // Fetch questions from Firestore
      final snapshot = await query.get();

      // Convert fetched documents into Question objects
      List<Question> questions = snapshot.docs.map((doc) {
        return Question.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      // Shuffle the list to randomize order
      questions.shuffle();
      return questions;
    } catch (e) {
      print("Firestore question fetch error: $e");
      return [];
    }
  }
}