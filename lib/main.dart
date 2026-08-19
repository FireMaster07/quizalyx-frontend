import 'package:QuizAlyx/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // ADDED: For Firestore checks
import 'login_screen.dart';
import 'package:flutter/services.dart';
import 'intro_screen.dart';
import 'onboarding_screen.dart'; // ADDED: We’ll redirect unfinished users here
import 'question_service.dart';
import 'currency_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'audio_manager.dart'; // ADDED
import 'package:google_mobile_ads/google_mobile_ads.dart'; // NEWLY ADDED

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ADDED LINE: We start the Firebase engine right here
  await Firebase.initializeApp();

  // START ADMOB SDK
  // await MobileAds.instance.initialize();

  AudioManager.instance.init(); // ADDED: We initialize the music manager

  await AppLanguage.loadLanguage();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // OLD: Load all questions into device memory (Now we have Firebase, so this is no longer needed)
  // --- Load questions from JSON ---
  // await QuestionService.loadQuestions();

  // --- Load Theme ---
  String savedTheme = await CurrencyManager.getActiveTheme();
  AppColors.themeNotifier.value = savedTheme;

  // --- GELİŞTİRİCİ ARACI: KOPYA SORULARI BUL ---
  // Sadece konsol (terminal) çıktısını görmek için kullanıyoruz.
  // Uygulamanın açılmasını engellememesi için başına 'await' KOYMUYORUZ.
  // QuestionService.findAndLogDuplicateQuestions();
  // ---------------------------------------------

  runApp(const QuizAlyxApp());
}

class QuizAlyxApp extends StatelessWidget {
  const QuizAlyxApp({super.key});

  @override
  Widget build(BuildContext context) {
    // --- 3. UPDATE: Nested Builder Structure ---
    // Outer: listens for theme changes (Gold/Normal)
    return ValueListenableBuilder<Locale>( // Changed from <bool> to <String>
      valueListenable: AppLanguage.localeNotifier, // Name updated
      builder: (context, currentLocale, child) {

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QuizAlyx',

          // --- MAGIC LANGUAGE ENGINE HERE ---
          locale: currentLocale, // The selected language is instantly reflected here
          localizationsDelegates: AppLocalizations.localizationsDelegates, // Automatic 15 language delegates
          supportedLocales: AppLocalizations.supportedLocales, // Automatic 15 language list
          // ---------------------------------

          // --- THEME SETTINGS ---
          // This now automatically updates when AppColors.primary changes
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,

            // Provide dynamic primary color
            primaryColor: AppColors.primary,

            // Material 3 color scheme (changing seed color updates everything)
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              brightness: Brightness.dark,
              surface: AppColors.surface,
              background: AppColors.background,
              primary: AppColors.primary, // Gold or Purple
            ),

            scaffoldBackgroundColor: AppColors.background,
            fontFamily: 'Inter',

            // Text styles (from your original code)
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
              bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
              bodyMedium: TextStyle(fontSize: 14, color: Colors.white60),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.surface,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // ADDED: Now AppRootRouter fully manages the initial launch
          home: const AppRootRouter(),
        );
      },
    );
  }
}

// --- NEWLY ADDED ROOT ROUTER ---
class AppRootRouter extends StatelessWidget {
  const AppRootRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. If waiting for connection, show loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // 2. If there IS a logged-in user
        if (snapshot.hasData && snapshot.data != null) {
          final uid = snapshot.data!.uid;

          // INDUSTRY STANDARD: Check if profile is completed in Firestore
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }

              // Does the user document exist AND contain a defined name?
              if (userSnapshot.hasData && userSnapshot.data!.exists) {
                final data = userSnapshot.data!.data() as Map<String, dynamic>?;
                if (data != null && data.containsKey('playerName')) {
                  // Profile complete, can proceed to main flow (Intro)
                  return const IntroScreen();
                }
              }

              // User is authenticated but skipped creating a profile! Force onboarding
              return const OnboardingScreen();
            },
          );
        }

        // 3. If not logged in, go directly to Login screen
        return const LoginScreen();
      },
    );
  }
}


// Design System - Colors (Same as your original code - preserved)
// At the bottom of main.dart

class AppColors {
  // CHANGE: Now we store a String instead of a bool ('default', 'gold', 'diamond')
  static final ValueNotifier<String> themeNotifier = ValueNotifier('default');

  // Get the current theme as a string
  static String get currentTheme => themeNotifier.value;

  // --- DYNAMIC COLORS ---
  static Color get primary {
    if (currentTheme == 'gold') return const Color(0xFFFFD700); // Gold
    if (currentTheme == 'diamond') return const Color(0xFF00E5FF); // Diamond (Minecraft Cyan)
    return const Color(0xFF7C3AED); // Default (Purple)
  }

  static Color get primaryLight {
    if (currentTheme == 'gold') return const Color(0xFFFFE57F);
    if (currentTheme == 'diamond') return const Color(0xFF80F3FF); // Light Diamond
    return const Color(0xFF9B6FFF);
  }

  static Color get primaryDark {
    if (currentTheme == 'gold') return const Color(0xFFC7A500);
    if (currentTheme == 'diamond') return const Color(0xFF00B2CC); // Dark Diamond
    return const Color(0xFF5B21B6);
  }

  // --- FIXED COLORS (Can remain const) ---
  static const background = Color(0xFF0A0A0F);
  static const surface = Color(0xFF15151E);
  static const surfaceLight = Color(0xFF1E1E2D);
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

class AppLanguage {
  // Our default language is English
  static final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));

  // Function that loads the language from memory when the app opens
  static Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('app_language') ?? 'en';
    localeNotifier.value = Locale(langCode);
  }

  // Function that runs when the user changes the language from settings
  static Future<void> changeLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language', langCode);
    localeNotifier.value = Locale(langCode);
  }
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