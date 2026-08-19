import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioManager with WidgetsBindingObserver {
  // Singleton Architecture (Only one copy lives across the entire app)
  static final AudioManager instance = AudioManager._internal();
  AudioManager._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  String _currentTrack = '';
  bool isSoundOn = true;

  // Called inside main.dart to start the lifecycle listener
  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  // Automatically triggered when the OS sends the app to background or brings it back
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioPlayer.pause(); // Pause music when minimized
    } else if (state == AppLifecycleState.resumed) {
      if (isSoundOn && _currentTrack.isNotEmpty) {
        _audioPlayer.resume(); // Resume music when returning
      }
    }
  }

  // To toggle sound on/off from Settings or Home Screen
  Future<void> toggleSound() async {
    isSoundOn = !isSoundOn;
    if (isSoundOn) {
      if (_currentTrack.isNotEmpty) {
        await _play(_currentTrack);
      }
    } else {
      await _audioPlayer.pause();
    }
  }

  Future<void> playHomeMusic() async {
    await _play('audio/life_of_riley.mp3');
  }

  Future<void> playQuestionMusic() async {
    await _play('audio/quiz-background-loop-thinking-news-275636.mp3');
  }

  Future<void> playWordAlyxMusic() async {
    await _play('audio/melodigne-quiz-music-209350.mp3');
  }

  // Smart Play Function
  Future<void> _play(String trackPath) async {
    if (!isSoundOn) {
      _currentTrack = trackPath; // If sound is off, just store it in memory
      return;
    }

    // If the same track is already playing, don’t restart! Continue from current position.
    if (_currentTrack == trackPath && _audioPlayer.state == PlayerState.playing) {
      return;
    }

    _currentTrack = trackPath;
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource(trackPath));
  }

  Future<void> stopMusic() async {
    await _audioPlayer.stop();
    _currentTrack = '';
  }
}
