import 'package:flutter/material.dart';

import '../core/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DutioPalette.of(context).background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: DutioPalette.of(context).textPrimary,
                ),
              ),
              const SizedBox(height: 24),

              // Profile Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: DutioPalette.of(context).sage,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        color: DutioPalette.of(context).surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 48,
                        color: DutioPalette.of(context).sage,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Nama Pengguna',
                      style: TextStyle(
                        color: DutioPalette.of(context).onAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'pengguna@email.com',
                      style: TextStyle(
                        color: DutioPalette.of(context).onAccent,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: DutioPalette.of(context).onAccent
                            .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Anggota • Kamar A',
                        style: TextStyle(
                          color: DutioPalette.of(context).onAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: DutioPalette.of(context).textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              _menuItem(
                context: context,
                icon: Icons.person_outline,
                title: 'Personal Information',
                subtitle: 'Manage your account details',
                onTap: () {},
              ),
              _menuItem(
                context: context,
                icon: Icons.notifications_none,
                title: 'Notifications',
                subtitle: 'Manage notification preferences',
                onTap: () {},
              ),
              _menuItem(
                context: context,
                icon: Icons.lock_outline,
                title: 'Privacy & Security',
                subtitle: 'Manage your account security',
                onTap: () {},
              ),

              const SizedBox(height: 24),

              Text(
                'About',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: DutioPalette.of(context).textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              _menuItem(
                context: context,
                icon: Icons.info_outline,
                title: 'About Dutio',
                subtitle: 'Learn more about Dutio',
                onTap: () {},
              ),
              _menuItem(
                context: context,
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Get help using Dutio',
                onTap: () {},
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.redAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: DutioPalette.of(context).surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: DutioPalette.of(context).surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: DutioPalette.of(context).accent),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: DutioPalette.of(context).textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 11,
            color: DutioPalette.of(context).secondaryText,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: DutioPalette.of(context).sage,
        ),
      ),
    );
  }
}
