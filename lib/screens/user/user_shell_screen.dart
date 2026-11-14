import 'package:flutter/material.dart';

import '../../widgets/dutio_widgets.dart';
import 'chat_screen.dart';
import 'home_screen.dart';
import 'mission_screen.dart';
import 'points_screen.dart';
import 'profile_screen.dart';

class UserShellScreen extends StatefulWidget {
  const UserShellScreen({super.key});

  @override
  State<UserShellScreen> createState() => _UserShellScreenState();
}

class _UserShellScreenState extends State<UserShellScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      bottom: false,
      child: IndexedStack(
        index: index,
        children: [
          UserHomeScreen(onMission: () => setState(() => index = 4)),
          const UserChatScreen(),
          const UserPointsScreen(),
          const UserProfileScreen(),
          const UserMissionScreen(),
        ],
      ),
    ),
    bottomNavigationBar: SafeArea(
      child: DutioBottomNav(
        selectedIndex: index > 3 ? 0 : index,
        onSelected: (value) => setState(() => index = value),
      ),
    ),
  );
}
