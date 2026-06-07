import 'dart:io'; // For internet connectivity check
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart'; // EKLENDİ: Hafıza kontrolü için
import 'auth_service.dart';
import 'firestore_service.dart';
import 'intro_screen.dart';
import 'main.dart';
import 'onboarding_screen.dart';
import 'l10n/app_localizations.dart';

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

    // EKLENDİ: Ekran çizildikten hemen sonra dil seçimi yapılmış mı diye kontrol et
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkFirstTimeLanguage();
    });
  }

  // --- İLK GİRİŞ DİL KONTROLÜ ---
  Future<void> _checkFirstTimeLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasSelectedLanguage = prefs.getBool('has_selected_language') ?? false;

    // Eğer dil daha önce seçilmemişse pencereyi göster
    if (!hasSelectedLanguage && mounted) {
      _showFirstTimeLanguageDialog();
    }
  }

  // --- İLK GİRİŞ DİL SEÇİM PENCERESİ (DIALOG) ---
  void _showFirstTimeLanguageDialog() {
    // Toplam 15 dilimiz
    final Map<String, String> languages = {
      'en': 'English', 'tr': 'Türkçe', 'de': 'Deutsch', 'fr': 'Français',
      'it': 'Italiano', 'es': 'Español', 'pt': 'Português', 'ar': 'العربية',
      'zh': '中文', 'ja': '日本語', 'ru': 'Русский', 'hi': 'हिन्दी',
      'el': 'Ελληνικά', 'fa': 'فارسی', 'ko': '한국어'
    };

    String selectedLang = 'en'; // Senin istediğin gibi varsayılan İngilizce

    showDialog(
        context: context,
        barrierDismissible: false, // Kullanıcı boşluğa tıklayıp kapatamasın, seçmek zorunda kalsın
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
                          "Select Language", // İngilizce sabit bırakıyoruz çünkü henüz dil seçmedi
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "You can always change this later in the Settings.",
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // Kaydırılabilir Dil Listesi
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 250), // Çok uzamasın diye limit
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
                                      // Siyah/Dolu yuvarlak görünümü
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

                        // Devam Butonu
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
                              // Hafızaya "bu adam dilini seçti" diye not düşüyoruz
                              await prefs.setBool('has_selected_language', true);

                              // Sistemi seçilen dile anında geçiriyoruz
                              AppLanguage.changeLanguage(selectedLang);

                              if (context.mounted) {
                                Navigator.of(context).pop(); // Pencereyi kapat
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

                    // PLAY AS GUEST BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const IntroScreen()),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.playAsGuest, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 12),

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

                            if (userDoc.exists) {
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
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const IntroScreen()),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.continueAsGuest,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.textSecondary,
                        ),
                      ),
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