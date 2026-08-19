import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'login_screen.dart'; // Where to return when the screen is finished

class CreditsScreen extends StatefulWidget {
  const CreditsScreen({super.key});

  @override
  State<CreditsScreen> createState() => _CreditsScreenState();
}

class _CreditsScreenState extends State<CreditsScreen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Start scrolling slowly 2 seconds after the screen starts.
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _startAutoScroll();
      }
    });
  }

  void _startAutoScroll() {
    // Scrolling speed: The larger it is, the slower it scrolls.
    final double maxExtent = _scrollController.position.maxScrollExtent;
    final int durationInSeconds = (maxExtent / 20).round(); // Pixels per second rate

    _scrollController.animateTo(
      maxExtent,
      duration: Duration(seconds: durationInSeconds),
      curve: Curves.linear,
    ).then((_) {
      // Return to LoginScreen when scrolling ends (or the user can tap the screen to exit)
      if (mounted) {
        Future.delayed(const Duration(seconds: 3), () {
          _goBackToLogin();
        });
      }
    });
  }

  void _goBackToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildCreditItem(String title, String name, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              color: isHighlight ? Colors.orangeAccent : Colors.white,
              fontSize: isHighlight ? 24 : 20,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Cinematic black background
      body: GestureDetector(
        onTap: _goBackToLogin, // Can skip animation and exit if screen is touched
        child: Stack(
          children: [
            ListView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              children: [
                // Space for starting
                SizedBox(height: MediaQuery.of(context).size.height * 0.4),

                // Main Title
                const Text(
                  "Q U I Z A L Y X   2 0 2 5",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),

                // Publishers
                _buildCreditItem(AppLocalizations.of(context)!.creditsPlayStorePublisher, "ZerefDragneel"),
                _buildCreditItem(AppLocalizations.of(context)!.creditsAppStorePublisher, "Jeovany Wilfred Afana"),

                // Development Environments
                _buildCreditItem(AppLocalizations.of(context)!.creditsIDEAndroid, "Android Studio"),
                _buildCreditItem(AppLocalizations.of(context)!.creditsIDEiOS, "Visual Studio Code"),

                // Database
                _buildCreditItem(AppLocalizations.of(context)!.creditsDatabase, "Firebase Console (Firestore Database)\nMuhammed Savcı Temel"),

                // Frontend
                _buildCreditItem(AppLocalizations.of(context)!.creditsFrontend, "Mamadou Dioulde Diallo\nMuhammed Savcı Temel"),

                // Backend
                _buildCreditItem(AppLocalizations.of(context)!.creditsBackend, "Eyüp İrfan Çelik"),

                // Production and Updates
                _buildCreditItem(AppLocalizations.of(context)!.creditsProduction, "ZerefDragneel"),

                // WordAlyx Update 2026
                _buildCreditItem(AppLocalizations.of(context)!.creditsWordAlyxUpdate, "Muhammed Savcı Temel"),

                const SizedBox(height: 40),

                // Producer (Grand Finale)
                _buildCreditItem(
                    AppLocalizations.of(context)!.creditsProducer,
                    "Muhammed Savcı Temel",
                    isHighlight: true
                ),

                // Space for ending
                SizedBox(height: MediaQuery.of(context).size.height * 0.6),
              ],
            ),

            // Small hint indicating that the user can skip
            Positioned(
              bottom: 24,
              right: 24,
              child: Opacity(
                opacity: 0.5,
                child: Text(
                  AppLocalizations.of(context)!.tapToSkip,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}