import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const QuizAlyxApp());
}

class QuizAlyxApp extends StatelessWidget {
  const QuizAlyxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizAlyx',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.white60,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surface,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: const IntroScreen(),
    );
  }
}

// Design System - Colors
class AppColors {
  static const background = Color(0xFF0A0A0F);
  static const surface = Color(0xFF15151E);
  static const surfaceLight = Color(0xFF1E1E2D);
  
  static const primary = Color(0xFF7C3AED);
  static const primaryLight = Color(0xFF9B6FFF);
  static const primaryDark = Color(0xFF5B21B6);
  
  static const accent = Color(0xFF10B981);
  static const accentOrange = Color(0xFFF59E0B);
  static const accentBlue = Color(0xFF3B82F6);
  static const accentPink = Color(0xFFEC4899);
  
  static const success = Color(0xFF10B981);
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);
  
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB4B4C6);
  static const textTertiary = Color(0xFF6B6B84);
}

// Design System - Spacing
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

// Design System - Border Radius
class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 9999;
}