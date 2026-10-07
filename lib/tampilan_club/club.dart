import 'package:flutter/material.dart';

class Club {
  final String name;
  final String sport;
  final String members;
  final String level;
  final IconData icon;
  final Color color;

  Club({
    required this.name,
    required this.sport,
    required this.members,
    required this.level,
    required this.icon,
    required this.color,
  });
}

final List<Club> sampleClubs = [
  Club(
    name: 'Holipok Padel Club',
    sport: 'Padel',
    members: '397 Members',
    level: '1.5',
    icon: Icons.sports_tennis,
    color: Colors.grey.shade300,
  ),
  Club(
    name: 'Garuda Football Club',
    sport: 'Sepak Bola',
    members: '1,250 Members',
    level: 'All Levels',
    icon: Icons.sports_soccer,
    color: Colors.green.shade700,
  ),
  Club(
    name: 'Jakarta Hoops Basketball',
    sport: 'Basket',
    members: '840 Members',
    level: 'Pro & Semi-Pro',
    icon: Icons.sports_basketball,
    color: Colors.orange.shade800,
  ),
  Club(
    name: 'Rise and Rally Tennis Society',
    sport: 'Tenis',
    members: '131 Members',
    level: 'All Levels',
    icon: Icons.sports_tennis,
    color: Colors.lightGreen.shade600,
  ),
  Club(
    name: 'Smash Badminton Community',
    sport: 'Bulu Tangkis',
    members: '920 Members',
    level: 'Intermediate',
    icon: Icons.sports_tennis,
    color: Colors.blue.shade600,
  ),
  Club(
    name: 'Urban Futsal Society',
    sport: 'Futsal',
    members: '512 Members',
    level: 'Casual & Fun',
    icon: Icons.sports_soccer,
    color: Colors.deepPurple.shade400,
  ),
];