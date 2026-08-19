import 'dart:io'; // For internet connectivity check
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ADDED: For memory check
import 'auth_service.dart';
import 'firestore_service.dart';
import 'intro_screen.dart';
import 'main.dart';
import 'onboarding_screen.dart';
import 'l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkConnection(); // Check internet as soon as the screen opens

    // ADDED: Right after the screen is drawn, check if the language has been selected and privacy policy accepted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkFirstTimeLanguage();
    });
  }

  // --- FIRST LOGIN LANGUAGE CHECK ---
  Future<void> _checkFirstTimeLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasSelectedLanguage = prefs.getBool('has_selected_language') ?? false;

    // If the language hasn't been selected before, show the dialog
    if (!hasSelectedLanguage && mounted) {
      _showFirstTimeLanguageDialog();
    } else {
      // If language is already selected, check Privacy Policy acceptance next
      _checkPrivacyPolicyOnStartup();
    }
  }

  // --- PRIVACY POLICY STARTUP CHECK ---
  Future<void> _checkPrivacyPolicyOnStartup() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasAcceptedPrivacy = prefs.getBool('hasAcceptedPrivacy') ?? false;

    if (!hasAcceptedPrivacy && mounted) {
      _showPrivacyPolicyDialog();
    }
  }

  // --- PRIVACY POLICY MANDATORY DIALOG ---
  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User cannot click outside to dismiss
      builder: (BuildContext context) {
        return PopScope(
          canPop: false, // Locks the back button
          child: Dialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shield_rounded, color: AppColors.primary, size: 56),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.privacyWelcomeTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppLocalizations.of(context)!.privacyWelcomeDesc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Read Privacy Policy Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.open_in_new_rounded, size: 18),
                      label: Text(AppLocalizations.of(context)!.readPrivacyPolicy),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        final Uri url = Uri.parse('https://quizalyx.web.app/privacy-policy.html');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Accept and Continue Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('hasAcceptedPrivacy', true);

                        if (context.mounted) {
                          Navigator.of(context).pop(); // Close the privacy dialog
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.acceptAndContinue,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- FIRST LOGIN LANGUAGE SELECTION WINDOW (DIALOG) ---
  void _showFirstTimeLanguageDialog() {
    // 15 languages in total
    final Map<String, String> languages = {
      'en': 'English', 'tr': 'Türkçe', 'de': 'Deutsch', 'fr': 'Français',
      'it': 'Italiano', 'es': 'Español', 'pt': 'Português', 'ar': 'العربية',
      'zh': '中文', 'ja': '日本語', 'ru': 'Русский', 'hi': 'हिन्दी',
      'el': 'Ελληνικά', 'fa': 'فارسی', 'ko': '한국어'
    };

    String selectedLang = 'en'; // Default English

    showDialog(
        context: context,
        barrierDismissible: false, // The user cannot click on the space to close it, they must select it
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setDialogState) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 2),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, spreadRadius: 5),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.language_rounded, color: AppColors.primary, size: 48),
                        const SizedBox(height: 16),
                        const Text(
                          "Select Language", // We leave English constant because the user hasn't selected a language yet
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "You can always change this later in the Settings.",
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // Scrollable Language List
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 250), // Limit so it doesn't get too long
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: languages.length,
                            itemBuilder: (context, index) {
                              String key = languages.keys.elementAt(index);
                              String name = languages.values.elementAt(index);
                              bool isSelected = selectedLang == key;

                              return GestureDetector(
                                onTap: () {
                                  setDialogState(() {
                                    selectedLang = key;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.primary.withOpacity(0.2) : AppColors.surfaceLight,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected ? AppColors.primary : Colors.transparent,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        name,
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : AppColors.textSecondary,
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                      ),
                                      // Black/Full round view
                                      Icon(
                                        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Continue Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () async {
                              final prefs = await SharedPreferences.getInstance();
                              // We make a note in memory saying "this man chose his language"
                              await prefs.setBool('has_selected_language', true);

                              // We instantly switch the system to the selected language
                              AppLanguage.changeLanguage(selectedLang);

                              if (context.mounted) {
                                Navigator.of(context).pop(); // Close the language window
                                // After language selection, trigger Privacy Policy dialog check
                                _checkPrivacyPolicyOnStartup();
                              }
                            },
                            child: const Text("Continue", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          );
        }
    );
  }

  // --- INTERNET CHECK FUNCTION ---
  Future<void> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Internet is available, no problem, user can use the buttons
      }
    } on SocketException catch (_) {
      // No internet, immediately show the offline warning panel
      if (mounted) {
        _showOfflineDialog();
      }
    }
  }

  // --- OFFLINE WARNING PANEL (DIALOG) ---
  void _showOfflineDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Align(
            alignment: const Alignment(0, -0.2),
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.surfaceLight, width: 2),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, spreadRadius: 5),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppColors.error.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.wifi_off_rounded, color: AppColors.error, size: 40),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!.offlineTitle,
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppLocalizations.of(context)!.offlineDesc,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // RETRY BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _checkConnection();
                        },
                        child: Text(AppLocalizations.of(context)!.retry, style: const TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [
                  AppColors.primary.withOpacity(0.15),
                  AppColors.background,
                  AppColors.background,
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.quiz_rounded, size: 80, color: AppColors.primaryLight),
                ),
                const SizedBox(height: 24),
                const Text(
                  "QUIZALYX",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 4),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.appSlogan,
                  style: const TextStyle(fontSize: 16, color: AppColors.textSecondary, letterSpacing: 1),
                ),
                const SizedBox(height: 60),

                _isLoading
                    ? CircularProgressIndicator(color: AppColors.primary)
                    : Column(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        minimumSize: const Size(280, 55),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 2,
                      ),
                      icon: const Icon(Icons.g_mobiledata_rounded, size: 36, color: Colors.blue),
                      label: Text(AppLocalizations.of(context)!.signInWithGoogle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        setState(() => _isLoading = true);

                        // 1. Google Sign-In Process
                        final userCredential = await AuthService().signInWithGoogle();

                        if (mounted) {
                          if (userCredential != null && userCredential.user != null) {
                            final uid = userCredential.user!.uid;

                            // 2. INDUSTRY STANDARD: Check if the user already exists in Firestore
                            final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

                            // Is there a document AND does it contain a defined name?
                            if (userDoc.exists && (userDoc.data() as Map<String, dynamic>).containsKey('playerName')) {
                              // SCENARIO A: Returning User (Has profile)
                              await FirestoreService().loadUserDataFromCloud(); // Pull existing XP/Coins
                              if (mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const IntroScreen()),
                                );
                              }
                            } else {
                              // SCENARIO B: Brand New User (Needs to pick an Avatar & Name)
                              if (mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                                );
                              }
                            }
                          } else {
                            // Login failed or was canceled
                            setState(() => _isLoading = false);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}