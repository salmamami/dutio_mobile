import 'package:flutter/material.dart';

import '../core/app_theme.dart';

class CrewPointsScreen extends StatelessWidget {
  const CrewPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      {'name': 'Aisyah Putri', 'room': 'Room A', 'points': 250},
      {'name': 'Nadia Safira', 'room': 'Room A', 'points': 220},
      {'name': 'Zahra Amelia', 'room': 'Room B', 'points': 190},
      {'name': 'Salsabila Rahma', 'room': 'Room A', 'points': 170},
      {'name': 'Hana Maulida', 'room': 'Room C', 'points': 150},
    ];

    return Scaffold(
      backgroundColor: DutioPalette.of(context).background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Crew Points',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: DutioPalette.of(context).textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Track your cleaning contributions',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 24),

              // Total Points Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: DutioPalette.of(context).sage,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.stars_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Your Total Points',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '250 pts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Great job! Keep your room clean.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              Text(
                'Leaderboard',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: DutioPalette.of(context).textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Top members with the highest points',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              ...List.generate(members.length, (index) {
                final member = members[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: DutioPalette.of(context).surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: index == 0
                              ? const Color(0xFFFFE7A3)
                              : DutioPalette.of(context).surfaceVariant,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: DutioPalette.of(context).textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: DutioPalette.of(context).surfaceVariant,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: DutioPalette.of(context).accent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member['name'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: DutioPalette.of(context).textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              member['room'] as String,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${member['points']} pts',
                        style: TextStyle(
                          color: DutioPalette.of(context).accent,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: DutioPalette.of(context).surfaceVariant,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: DutioPalette.of(context).accent,
                      size: 25,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Every completed task brings you closer to a cleaner and better dormitory!',
                        style: TextStyle(
                          fontSize: 12,
                          color: DutioPalette.of(context).textPrimary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
