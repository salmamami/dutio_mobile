import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool darkMode = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 220,
            decoration: const BoxDecoration(
              color: AppTheme.sage,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(150)),
            ),
          ),
          Positioned(
            top: 20,
            left: 16,
            child: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back_rounded, color: AppTheme.white),
            ),
          ),
          const Positioned(top: 24, right: 24, child: DutioLogo(size: 38)),
          const Positioned(
            top: 28,
            child: Text(
              'Crew',
              style: TextStyle(
                color: AppTheme.cream,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Positioned(
            top: 104,
            child: Container(
              width: 144,
              height: 144,
              decoration: const BoxDecoration(
                color: Color(0xFFD8D8D8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                size: 96,
                color: AppTheme.ink,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 32),
      const Text(
        'Kamar A',
        style: TextStyle(
          color: AppTheme.ink,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 18),
      Expanded(
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
          decoration: const BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(44)),
          ),
          child: Material(
            color: AppTheme.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
                  child: Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                ),
                SwitchListTile(
                  value: darkMode,
                  onChanged: (value) => setState(() => darkMode = value),
                  title: const Text('Dark Mode'),
                  secondary: const Icon(Icons.sunny, color: Colors.amber),
                  activeThumbColor: AppTheme.darkGreen,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                SwitchListTile(
                  value: notifications,
                  onChanged: (value) => setState(() => notifications = value),
                  title: const Text('Notification'),
                  secondary: const Icon(
                    Icons.notifications_active_outlined,
                    color: Color(0xFFCA9A3D),
                  ),
                  activeThumbColor: AppTheme.darkGreen,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                _setting(
                  context,
                  Icons.shield_outlined,
                  'Password',
                  '/password',
                ),
                _setting(
                  context,
                  Icons.account_circle_outlined,
                  'Account',
                  '/account',
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: AppTheme.sage),
                  title: const Text('About'),
                  trailing: const Text(
                    'DUTIO 1.0.0',
                    style: TextStyle(color: AppTheme.charcoal, fontSize: 11),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Logout'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.darkGreen,
                    side: const BorderSide(color: AppTheme.lightGreen),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );

  Widget _setting(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) => ListTile(
    leading: Icon(icon, color: AppTheme.darkGreen),
    title: Text(title),
    trailing: const Icon(Icons.chevron_right_rounded, color: Colors.black26),
    onTap: () =>
        Navigator.pushNamed(context, route, arguments: DutioRole.member),
  );
}
