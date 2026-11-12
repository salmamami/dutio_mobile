
import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      children: [
                        const Icon(
                          Icons.eco_outlined,
                          color: AppTheme.darkGreen,
                          size: 27,
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.dark,
                                ),
                              ),
                              Text(
                                'Kamar A',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _headerButton(Icons.notifications_none),
                        const SizedBox(width: 9),
                        _headerButton(Icons.person_outline),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // HERO BANNER
                    Container(
                      width: double.infinity,
                      height: 185,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8EEDC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 17,
                            top: 22,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Crew',
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.darkGreen,
                                  ),
                                ),
                                const Text(
                                  'on Duty',
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.darkGreen,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.darkGreen,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Do your best, keep it clean!',
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            right: 12,
                            bottom: 5,
                            child: Text(
                              '🧹',
                              style: TextStyle(fontSize: 95),
                            ),
                          ),
                          const Positioned(
                            right: 85,
                            top: 15,
                            child: Text(
                              '✨',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          const Positioned(
                            right: 25,
                            top: 20,
                            child: Text(
                              '🌱',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ROOM INFORMATION
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.sage,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kamar A',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Kamar mandi & kebersihan kamar',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // DATE AND TIME
                    Row(
                      children: [
                        Expanded(
                          child: _infoCard(
                            Icons.calendar_month_outlined,
                            'Rabu, 12 November 2026',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _infoCard(
                            Icons.access_time,
                            '07:30 - 09:30',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 23),

                    const Text(
                      'Yuk mulai melakukan piket!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkGreen,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // CHECKLIST BUTTON CARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppTheme.lightGreen,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.checklist_rounded,
                              color: AppTheme.darkGreen,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'To Do Checklist',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.dark,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'Lihat tugas piketmu hari ini',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: AppTheme.darkGreen,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // BOTTOM NAVIGATION
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.home_rounded,
                    label: 'Home',
                    active: true,
                  ),
                  _NavItem(
                    icon: Icons.check_circle_outline,
                    label: 'Mission',
                  ),
                  _NavItem(
                    icon: Icons.emoji_events_outlined,
                    label: 'Points',
                  ),
                  _NavItem(
                    icon: Icons.person_outline,
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _headerButton(IconData icon) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.lightGreen),
      ),
      child: Icon(
        icon,
        color: AppTheme.darkGreen,
        size: 19,
      ),
    );
  }

  static Widget _infoCard(IconData icon, String text) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.darkGreen, size: 18),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 9,
                color: AppTheme.dark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 22,
          color: active ? AppTheme.darkGreen : Colors.grey,
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: active ? AppTheme.darkGreen : Colors.grey,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
