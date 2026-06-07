import 'package:flutter/material.dart';

class AvatarHelper {
  // Game avatars consisting of 20 different color and icon combinations
  static final List<AvatarData> avatars = [
    AvatarData(icon: Icons.rocket_launch, colors: [Colors.deepPurple, Colors.purpleAccent]),
    AvatarData(icon: Icons.pets, colors: [Colors.orange, Colors.deepOrangeAccent]),
    AvatarData(icon: Icons.bolt, colors: [Colors.yellow.shade700, Colors.amberAccent]),
    AvatarData(icon: Icons.cruelty_free, colors: [Colors.pink, Colors.pinkAccent]),
    AvatarData(icon: Icons.local_fire_department, colors: [Colors.red, Colors.orangeAccent]),
    AvatarData(icon: Icons.ac_unit, colors: [Colors.cyan, Colors.lightBlue]),
    AvatarData(icon: Icons.diamond, colors: [Colors.teal, Colors.tealAccent]),
    AvatarData(icon: Icons.smart_toy, colors: [Colors.blueGrey, Colors.grey]),
    AvatarData(icon: Icons.bug_report, colors: [Colors.green, Colors.lightGreen]),
    AvatarData(icon: Icons.sports_esports, colors: [Colors.indigo, Colors.blueAccent]),
    AvatarData(icon: Icons.favorite, colors: [Colors.redAccent, Colors.pink.shade300]),
    AvatarData(icon: Icons.star_rounded, colors: [Colors.amber, Colors.yellowAccent]),
    AvatarData(icon: Icons.dark_mode, colors: [Colors.black87, Colors.deepPurple]),
    AvatarData(icon: Icons.public, colors: [Colors.blue, Colors.greenAccent]),
    AvatarData(icon: Icons.psychology, colors: [Colors.brown, Colors.orange]),
    AvatarData(icon: Icons.anchor, colors: [Colors.blueGrey.shade800, Colors.cyanAccent]),
    AvatarData(icon: Icons.auto_awesome, colors: [Colors.purple, Colors.cyan]),
    AvatarData(icon: Icons.catching_pokemon, colors: [Colors.deepOrange, Colors.yellow]),
    AvatarData(icon: Icons.cookie, colors: [Colors.brown.shade700, Colors.brown.shade300]),
    AvatarData(icon: Icons.filter_vintage, colors: [Colors.pink.shade300, Colors.purple.shade200]),
  ];

  // Function that draws the avatar on screen based on the index coming from the database
  static Widget buildAvatar(int index, {double radius = 40}) {
    // If an invalid index is provided, show the first one by default (Safety)
    final safeIndex = (index >= 0 && index < avatars.length) ? index : 0;
    final avatar = avatars[safeIndex];

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: avatar.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: avatar.colors[0].withValues(alpha: 0.4),
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white.withValues(alpha: 0.2), // Semi-transparent background
        child: Icon(
          avatar.icon,
          size: radius * 1.2,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AvatarData {
  final IconData icon;
  final List<Color> colors;

  AvatarData({required this.icon, required this.colors});
}
