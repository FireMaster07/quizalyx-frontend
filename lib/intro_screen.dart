import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {

  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  late Animation<double> _opacityAnimation;

  bool showLogo = false;
  bool transitionStarted = false;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _glowAnimation = Tween<double>(begin: 20, end: 45).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _glowController,
        curve: Curves.easeIn,
      ),
    );

    _glowController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _glowController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _glowController.forward();
      }
    });

    // --- First: 5 seconds pure black ---
    Timer(const Duration(seconds: 5), () {
      setState(() => showLogo = true);
      _glowController.forward();
    });

    // --- After 5 sec black + 4 sec logo = go to HomeScreen ---
    Timer(const Duration(seconds: 9), () {
      if (!transitionStarted) {
        transitionStarted = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: !showLogo
            ? Container() // 5 seconds pure black
            : AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Text(
                "QUIZALYX",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 6,
                  shadows: [
                    Shadow(
                      color: Colors.deepPurpleAccent.withOpacity(0.9),
                      blurRadius: _glowAnimation.value,
                    ),
                    Shadow(
                      color: Colors.purple.withOpacity(0.6),
                      blurRadius: _glowAnimation.value * 0.6,
                    ),
                    Shadow(
                      color: Colors.deepPurple.withOpacity(0.4),
                      blurRadius: _glowAnimation.value * 0.3,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
