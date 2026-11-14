import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../core/app_theme_controller.dart';
import '../../widgets/dutio_widgets.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
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
            decoration: BoxDecoration(
              color: DutioPalette.of(context).sage,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(150)),
            ),
          ),
          Positioned(
            top: 20,
            left: 16,
            child: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: DutioPalette.of(context).onAccent,
              ),
            ),
          ),
          const Positioned(top: 24, right: 24, child: DutioLogo(size: 38)),
          Positioned(
            top: 28,
            child: Text(
              'Crew',
              style: TextStyle(
                color: DutioPalette.of(context).onAccent,
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
              decoration: BoxDecoration(
                color: DutioPalette.of(context).surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_outline_rounded,
                size: 96,
                color: DutioPalette.of(context).textPrimary,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 32),
      Text(
        'Kamar A',
        style: TextStyle(
          color: DutioPalette.of(context).textStrong,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 18),
      Expanded(
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
          decoration: BoxDecoration(
            color: DutioPalette.of(context).surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(44)),
          ),
          child: Material(
            color: DutioPalette.of(context).surface,
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
                AnimatedBuilder(
                  animation: AppThemeController.instance,
                  builder: (context, _) => SwitchListTile(
                    value: AppThemeController.instance.isDarkMode,
                    onChanged: AppThemeController.instance.setDarkMode,
                    title: const Text('Dark Mode'),
                    secondary: const Icon(Icons.sunny, color: Colors.amber),
                    activeThumbColor: DutioPalette.of(context).accent,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
                SwitchListTile(
                  value: notifications,
                  onChanged: (value) => setState(() => notifications = value),
                  title: const Text('Notification'),
                  secondary: const Icon(
                    Icons.notifications_active_outlined,
                    color: Color(0xFFCA9A3D),
                  ),
                  activeThumbColor: DutioPalette.of(context).accent,
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
                  leading: Icon(
                    Icons.info_outline,
                    color: DutioPalette.of(context).accent,
                  ),
                  title: const Text('About'),
                  trailing: Text(
                    'DUTIO 1.0.0',
                    style: TextStyle(
                      color: DutioPalette.of(context).secondaryText,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Logout'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: DutioPalette.of(context).accent,
                    side: BorderSide(color: DutioPalette.of(context).border),
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
    leading: Icon(icon, color: DutioPalette.of(context).accent),
    title: Text(title),
    trailing: Icon(
      Icons.chevron_right_rounded,
      color: DutioPalette.of(context).secondaryText,
    ),
    onTap: () =>
        Navigator.pushNamed(context, route, arguments: DutioRole.member),
  );
}
