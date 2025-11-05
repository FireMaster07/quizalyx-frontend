import 'package:flutter/material.dart';
import 'question_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSoundOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),

            // QUIZALYX title
            const Text(
              'QUIZALYX',
              style: TextStyle(
                fontSize: 48,
                color: Color(0xFF7A3CF4),
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoMono',
              ),
            ),

            // START button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QuestionScreen()),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00FFFF), Color(0xFF00BFFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.blueAccent, width: 3),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.blueAccent,
                      offset: Offset(3, 3),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: const Text(
                  'START',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ),

            // Bottom icons
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 40,
                    color: Colors.white,
                    icon: Icon(isSoundOn ? Icons.volume_up : Icons.volume_off),
                    onPressed: () {
                      setState(() {
                        isSoundOn = !isSoundOn;
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 40,
                    color: Colors.white,
                    icon: const Icon(Icons.leaderboard),
                    onPressed: () {},
                  ),
                  IconButton(
                    iconSize: 40,
                    color: Colors.white,
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
