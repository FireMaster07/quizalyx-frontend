import 'dart:math';
import 'package:flutter/material.dart';

class LeaderboardsScreen extends StatelessWidget {
  const LeaderboardsScreen({super.key});

  List<Map<String, dynamic>> _generateDummyData() {
    final random = Random();
    final names = [
      'A.R.M',
      'J.???',
      'M.T.K.',
      'L?X',
      'K??',
      'S...',
      '??N',
      'R???',
      'P.T.',
      'Z???'
    ];

    return List.generate(names.length, (i) {
      return {
        'name': names[i],
        'score': 500 + random.nextInt(500), // 500–999 arası puan
      };
    })..sort((a, b) => b['score'].compareTo(a['score']));
  }

  @override
  Widget build(BuildContext context) {
    final leaderboardData = _generateDummyData();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'LEADERBOARDS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono',
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: leaderboardData.length,
        itemBuilder: (context, index) {
          final item = leaderboardData[index];
          final rank = index + 1;

          return ListTile(
            leading: Text(
              '$rank',
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(
              item['name'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Text(
              '${item['score']} pts',
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
