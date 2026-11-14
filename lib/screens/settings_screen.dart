import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/dutio_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.role});

  final DutioRole role;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    final isMember = widget.role == DutioRole.member;
    final person = isMember ? 'Kamar A' : 'Koordinator';
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 224,
                  decoration: const BoxDecoration(
                    color: AppTheme.sage,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(150),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppTheme.white,
                    ),
                  ),
                ),
                const Positioned(
                  top: 20,
                  right: 24,
                  child: DutioLogo(size: 38),
                ),
                Positioned(
                  top: 26,
                  child: Text(
                    isMember ? 'Crew' : 'Captain',
                    style: const TextStyle(
                      color: AppTheme.cream,
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Positioned(
                  top: 96,
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
            Text(
              person,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
                decoration: const BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(42)),
                ),
                child: Material(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(42),
                  ),
                  child: ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SwitchListTile(
                        value: darkMode,
                        onChanged: (value) => setState(() => darkMode = value),
                        title: const Text('Dark Mode'),
                        secondary: const Icon(Icons.sunny, color: Colors.amber),
                        activeThumbColor: AppTheme.darkGreen,
                      ),
                      SwitchListTile(
                        value: notifications,
                        onChanged: (value) =>
                            setState(() => notifications = value),
                        title: const Text('Notification'),
                        secondary: const Icon(
                          Icons.notifications_none_rounded,
                          color: Color(0xFFC49A48),
                        ),
                        activeThumbColor: AppTheme.darkGreen,
                      ),
                      _routeTile(
                        context,
                        Icons.shield_outlined,
                        'Password',
                        '/password',
                      ),
                      _routeTile(
                        context,
                        Icons.account_circle_outlined,
                        'Account',
                        '/account',
                      ),
                      const ListTile(
                        leading: Icon(Icons.info_outline, color: AppTheme.sage),
                        title: Text('About'),
                        trailing: Text(
                          'DUTIO 1.0.0',
                          style: TextStyle(color: AppTheme.charcoal),
                        ),
                      ),
                      const SizedBox(height: 8),
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
        ),
      ),
    );
  }

  Widget _routeTile(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) => ListTile(
    leading: Icon(icon, color: AppTheme.darkGreen),
    title: Text(title),
    trailing: const Icon(Icons.chevron_right_rounded, color: Colors.black26),
    onTap: () => Navigator.pushNamed(context, route, arguments: widget.role),
  );
}
