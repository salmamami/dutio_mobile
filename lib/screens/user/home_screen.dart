import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({
    super.key,
    required this.onMission,
    required this.hasUnreadNotifications,
    required this.onNotifications,
  });

  final VoidCallback onMission;
  final bool hasUnreadNotifications;
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
        child: Row(
          children: [
            const DutioLogo(size: 38),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome', style: TextStyle(fontSize: 12)),
                  Text(
                    'Kamar A',
                    style: TextStyle(
                      color: DutioPalette.of(context).accent,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            _roundIcon(
              context,
              Icons.notifications_none_rounded,
              onNotifications,
              showBadge: hasUnreadNotifications,
            ),
            const SizedBox(width: 10),
            _roundIcon(context, Icons.person_outline_rounded, () {
              Navigator.pushNamed(context, '/settings');
            }),
          ],
        ),
      ),
      Expanded(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 36),
          children: [
            Container(
              height: 190,
              decoration: BoxDecoration(
                color: DutioPalette.of(context).homeHeroBlush,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 18,
                    right: 126,
                    top: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Crew',
                          style: TextStyle(
                            color: DutioPalette.of(context).background,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            height: .95,
                          ),
                        ),
                        Text(
                          'on Duty',
                          style: TextStyle(
                            color: DutioPalette.of(context).accent,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Cek detail piket kamu 🌱',
                          style: TextStyle(
                            color: DutioPalette.of(context).textPrimary
                                .withValues(alpha: .8),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 0,
                    width: 130,
                    height: 155,
                    child: Image.asset(
                      'assets/images/mbak.png',
                      key: const ValueKey('crew-duty-image'),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: DutioPalette.of(context).sage,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kamar A',
                    style: TextStyle(
                      color: DutioPalette.of(context).onAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Kamar Mandi Kompleks Lantai 1',
                    style: TextStyle(
                      color: DutioPalette.of(context).textStrong,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _roomInfo(
                    context,
                    Icons.calendar_month_rounded,
                    'Rabu, 3 Desember 2025',
                  ),
                  const SizedBox(height: 8),
                  _roomInfo(
                    context,
                    Icons.access_time_rounded,
                    '07.00 – 09.00',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _homeAction(
              context,
              title: 'Ketuk untuk melihat tugas piket area',
              label: 'To Do Checklist',
              icon: Icons.fact_check_rounded,
              onTap: onMission,
            ),
            const SizedBox(height: 14),
            _homeAction(
              context,
              title: 'Ketuk untuk mengunggah foto laporan',
              label: 'Laporan',
              icon: Icons.cloud_upload_rounded,
              onTap: () => Navigator.pushNamed(context, '/user/report'),
            ),
          ],
        ),
      ),
    ],
  );

  static Widget _roundIcon(
    BuildContext context,
    IconData icon,
    VoidCallback onTap, {
    bool showBadge = false,
  }) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(25),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: DutioPalette.of(context).neutralSurface,
          child: Icon(
            icon,
            color: DutioPalette.of(context).textStrong,
            size: 25,
          ),
        ),
        if (showBadge)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              key: const ValueKey('unread-notification-badge'),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                shape: BoxShape.circle,
                border: Border.all(
                  color: DutioPalette.of(context).neutralSurface,
                  width: 1.5,
                ),
              ),
            ),
          ),
      ],
    ),
  );

  static Widget _roomInfo(BuildContext context, IconData icon, String label) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: DutioPalette.of(context).surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(icon, color: DutioPalette.of(context).textStrong, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: DutioPalette.of(context).textPrimary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );

  static Widget _homeAction(
    BuildContext context, {
    required String title,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) => Container(
    decoration: BoxDecoration(
      color: DutioPalette.of(context).surface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: DutioPalette.of(context).border),
      boxShadow: [
        BoxShadow(
          color: DutioPalette.of(context).blush,
          offset: Offset(0, 5),
          blurRadius: 0,
        ),
      ],
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: DutioPalette.of(context).accent,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  icon,
                  color: DutioPalette.of(context).textStrong,
                  size: 36,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      color: DutioPalette.of(context).softSurface,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: DutioPalette.of(context).textStrong,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
