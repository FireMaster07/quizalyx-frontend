import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'avatar_helper.dart'; // Our avatar repository we just wrote
import 'intro_screen.dart';
import 'main.dart'; // For AppColors
import 'l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _selectedAvatarIndex = 0; // By default, the first avatar is selected
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _completeSetup() async {
    String name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.enterPlayerNameError)),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // 1. Update Firebase Auth profile
        await user.updateDisplayName(name);

        // 2. Insert initial records into Users and Leaderboard collections!
        Map<String, dynamic> userData = {
          'playerName': name, // CRITICAL FIX: We used playerName instead of displayName!
          'avatarIndex': _selectedAvatarIndex, // Which visual did they choose?
          'nameChangeCount': 0, // Since it's the first login, full rights
          'lastNameChangeDate': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
        };

        // Save the user into the users collection (safe write with merge: true)
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(userData, SetOptions(merge: true));

        // Save into the leaderboard
        await FirebaseFirestore.instance.collection('leaderboard').doc(user.uid).set({
          'displayName': name, // Leaderboard screen usually uses displayName, this can stay
          'avatarIndex': _selectedAvatarIndex,
          'score': 0, // Starts the game with zero points
        }, SetOptions(merge: true));

        // 3. CORRECT ROUTING (Fixes the routing bug)
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const IntroScreen()), // Go directly to IntroScreen
          );
        }
      }
    } catch (e) {
      print("Onboarding Error: $e");
      if (mounted) {
        setState(() => _isLoading = false); // If error occurs, button returns to normal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ADDED SINGLE-LINE MAGIC CODE:
      resizeToAvoidBottomInset: false,

      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.welcomeToQuizAlyx,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.chooseAvatarName,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 30),

            // Show the selected avatar in large size
            AvatarHelper.buildAvatar(_selectedAvatarIndex, radius: 50),
            const SizedBox(height: 20),

            // Name input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _nameController,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterPlayerNameHint,
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Avatar selection grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Fit 4 side by side
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: AvatarHelper.avatars.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedAvatarIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAvatarIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
                        ),
                        // Selected one slightly enlarges, others fade
                        child: Opacity(
                          opacity: isSelected ? 1.0 : 0.5,
                          child: AvatarHelper.buildAvatar(index, radius: 25),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Start Journey button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: _isLoading ? null : _completeSetup,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    AppLocalizations.of(context)!.startJourney,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
