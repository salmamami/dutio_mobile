import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class UserMissionScreen extends StatefulWidget {
  const UserMissionScreen({super.key});

  @override
  State<UserMissionScreen> createState() => _UserMissionScreenState();
}

class _UserMissionScreenState extends State<UserMissionScreen> {
  final List<String> tasks = const [
    'Menyapu lantai kamar mandi',
    'Membersihkan wastafel',
    'Menyikat kloset',
    'Menguras bak',
  ];
  final Set<int> completed = {};
  bool showCompleted = false;

  @override
  Widget build(BuildContext context) {
    final visible = tasks.asMap().entries.where(
      (entry) => showCompleted ? completed.contains(entry.key) : true,
    );
    return Container(
      color: DutioPalette.of(context).sage,
      child: Column(
        children: [
          SizedBox(
            height: 322,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 190,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6E6C6),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                        right: 22,
                        top: 24,
                        child: DutioMissionLogo(),
                      ),
                      Center(
                        child: Text(
                          'Mission Cleanliness',
                          style: TextStyle(
                            color: DutioPalette.of(context).textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18,
                        top: 20,
                        child: IconButton(
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 142,
                  left: 18,
                  right: 18,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: DutioPalette.of(context).blush
                          .withValues(alpha: .95),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Progress',
                          style: TextStyle(
                            color: DutioPalette.of(context).onAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _statCard(
                              'Kamar A',
                              '36 orang',
                              Icons.people_alt_rounded,
                            ),
                            _statCard('2', 'jam', Icons.timer_rounded),
                            _statCard(
                              '${completed.length}/${tasks.length}',
                              'task completed',
                              Icons.assignment_turned_in_rounded,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Centang tugas yang sudah selesai untuk memperbarui progres.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.ink,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              key: const ValueKey('mission-lower-panel'),
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              decoration: BoxDecoration(
                color: DutioPalette.of(context).surfaceVariant,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Daftar Tugas',
                      style: TextStyle(
                        color: DutioPalette.of(context).textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _tab(
                        'Task List',
                        !showCompleted,
                        () => setState(() => showCompleted = false),
                      ),
                      const SizedBox(width: 8),
                      _tab(
                        'Completed Task',
                        showCompleted,
                        () => setState(() => showCompleted = true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      key: const ValueKey('mission-task-panel'),
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: DutioPalette.of(context).background,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: visible.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    showCompleted
                                        ? Icons.check_circle_outline_rounded
                                        : Icons.assignment_outlined,
                                    size: 44,
                                    color: DutioPalette.of(context).accent,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    showCompleted
                                        ? 'Belum ada tugas yang selesai.'
                                        : 'Belum ada tugas.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: DutioPalette.of(context)
                                          .textPrimary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    showCompleted
                                        ? 'Yuk, mulai kerjakan piketmu!'
                                        : 'Tugas piket akan muncul di sini.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: DutioPalette.of(context)
                                          .secondaryText,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView(
                              key: const ValueKey('mission-task-list'),
                              children: [
                                for (final entry in visible)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: Material(
                                      color: completed.contains(entry.key)
                                          ? DutioPalette.of(context)
                                                .surfaceVariant
                                          : DutioPalette.of(context).surface,
                                      borderRadius: BorderRadius.circular(20),
                                      child: CheckboxListTile(
                                        value: completed.contains(entry.key),
                                        activeColor: DutioPalette.of(context)
                                            .accent,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                        title: Text(
                                          entry.value,
                                          style: TextStyle(
                                            color: completed.contains(entry.key)
                                                ? DutioPalette.of(context)
                                                      .secondaryText
                                                : DutioPalette.of(context)
                                                      .textStrong,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            decoration:
                                                completed.contains(entry.key)
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                          ),
                                        ),
                                        onChanged: (value) => setState(() {
                                          if (value == true) {
                                            completed.add(entry.key);
                                          } else {
                                            completed.remove(entry.key);
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String subtitle, IconData icon) => Expanded(
    child: Container(
      height: 76,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: DutioPalette.of(context).surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 19, color: DutioPalette.of(context).accent),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
          ),
          Text(subtitle, style: const TextStyle(fontSize: 9)),
        ],
      ),
    ),
  );

  Widget _tab(String label, bool active, VoidCallback onTap) => Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: active
              ? DutioPalette.of(context).mutedSurface
              : DutioPalette.of(context).background,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: active
                ? DutioPalette.of(context).onMutedSurface
                : DutioPalette.of(context).secondaryText,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

class DutioMissionLogo extends StatelessWidget {
  const DutioMissionLogo({super.key});

  @override
  Widget build(BuildContext context) => const DutioLogo(size: 50);
}
