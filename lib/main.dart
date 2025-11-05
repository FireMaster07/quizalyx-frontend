import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const QuizAlyxApp());
}

class QuizAlyxApp extends StatelessWidget {
  const QuizAlyxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizAlyx',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
