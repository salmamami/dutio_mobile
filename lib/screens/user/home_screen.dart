import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key, required this.onMission});

  final VoidCallback onMission;

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
            _roundIcon(context, Icons.notifications_none_rounded, () {
              Navigator.pushNamed(context, '/notifications');
            }),
            const SizedBox(width: 10),
            _roundIcon(context, Icons.person_outline_rounded, () {
              Navigator.pushNamed(context, '/settings');
            }),
          ],
        ),
      ),
      Expanded(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 22),
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
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 8,
                    child: Container(
                      width: 106,
                      height: 130,
                      decoration: BoxDecoration(
                        color: DutioPalette.of(context).warmSurface,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Icon(
                        Icons.cleaning_services_rounded,
                        color: DutioPalette.of(context).accent,
                        size: 74,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 83,
                    top: 14,
                    child: Icon(
                      Icons.auto_awesome,
                      color: DutioPalette.of(context).background,
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
                  const Text(
                    'Kamar Mandi Kompleks Lantai 1',
                    style: TextStyle(color: AppTheme.white, fontSize: 12),
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
    VoidCallback onTap,
  ) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(25),
    child: CircleAvatar(
      radius: 22,
      backgroundColor: DutioPalette.of(context).neutralSurface,
      child: Icon(icon, color: DutioPalette.of(context).textStrong, size: 25),
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
