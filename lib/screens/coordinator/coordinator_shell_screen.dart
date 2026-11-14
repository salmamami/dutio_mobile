import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';
import '../settings_screen.dart';
import 'chat_screen.dart';
import 'coordinator_home_screen.dart';

class CoordinatorShellScreen extends StatefulWidget {
  const CoordinatorShellScreen({super.key});

  @override
  State<CoordinatorShellScreen> createState() => _CoordinatorShellScreenState();
}

class _CoordinatorShellScreenState extends State<CoordinatorShellScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      bottom: false,
      child: IndexedStack(
        index: index,
        children: [
          const CoordinatorHomeScreen(),
          const CoordinatorChatScreen(),
          const SettingsScreen(role: DutioRole.coordinator),
        ],
      ),
    ),
    bottomNavigationBar: SafeArea(
      child: DutioBottomNav(
        coordinator: true,
        selectedIndex: index,
        onSelected: (value) => setState(() => index = value),
      ),
    ),
  );
}
