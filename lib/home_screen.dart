import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'question_screen.dart';
import 'settings_screen.dart';
import 'leaderboards_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool isSoundOn = true;
  bool showModeSelection = false;
  bool hasMusicStarted = false;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _audioPlayer = AudioPlayer();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!kIsWeb) {
        await _playBackgroundMusic();
      } else {
        debugPrint("Automatic audio playback is blocked on the web platform (Chrome policy).");
      }
    });
  }

  // Play main background music
  Future<void> _playBackgroundMusic() async {
    if (!isSoundOn || hasMusicStarted) return;
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.play(AssetSource('audio/life_of_riley.mp3'));
      hasMusicStarted = true;
    } catch (e) {
      debugPrint('Error playing music: $e');
    }
  }

  // Stop main background music
  Future<void> _stopBackgroundMusic() async {
    await _audioPlayer.stop();
    hasMusicStarted = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
    super.dispose();
  }

  // Lifecycle handler
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // Stop music when app goes background
      _stopBackgroundMusic();
    } else if (state == AppLifecycleState.resumed && isSoundOn) {
      // Resume only if still on HomeScreen
      if (mounted && ModalRoute.of(context)?.isCurrent == true) {
        _playBackgroundMusic();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),
            const Text(
              'QUIZALYX',
              style: TextStyle(
                fontSize: 48,
                color: Color(0xFF7A3CF4),
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoMono',
              ),
            ),
            showModeSelection
                ? _buildModeSelection(context)
                : _buildStartButton(),
            Padding(
              padding: const EdgeInsets.only(bottom: 15), // ↓ Reduced extra bottom space by 50%
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 40,
                    color: Colors.white,
                    icon: Icon(isSoundOn ? Icons.volume_up : Icons.volume_off),
                    onPressed: () async {
                      setState(() => isSoundOn = !isSoundOn);
                      if (isSoundOn) {
                        await _playBackgroundMusic();
                      } else {
                        await _stopBackgroundMusic();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.leaderboard, color: Colors.white, size: 40),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LeaderboardsScreen(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white, size: 40),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    return GestureDetector(
      onTap: () async {
        await _playBackgroundMusic();
        setState(() {
          showModeSelection = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 40),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7A3CF4), Color(0xFF9B30FF)], // Shockwave purple gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: const Color(0xFF7A3CF4), width: 3),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF7A3CF4),
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
    );
  }

  Widget _buildModeSelection(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Select Mode',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildModeButton(context, 'Classic', Colors.greenAccent, 'classic'),
            _buildModeButton(context, 'Timed', Colors.yellowAccent, 'timed'),
            _buildModeButton(context, 'Endless', Colors.blueAccent, 'endless'),
          ],
        ),
      ],
    );
  }

  Widget _buildModeButton(BuildContext context, String text, Color color, String mode) {
    return ElevatedButton(
      onPressed: () async {
        await _stopBackgroundMusic(); // Stop home music before entering question
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => QuestionScreen(mode: mode)),
        );
        if (isSoundOn) {
          await _playBackgroundMusic(); // Resume home music when returning
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: color,
        side: BorderSide(color: color, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
