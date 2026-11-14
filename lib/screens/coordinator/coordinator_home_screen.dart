import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class CoordinatorHomeScreen extends StatefulWidget {
  const CoordinatorHomeScreen({super.key});

  @override
  State<CoordinatorHomeScreen> createState() => _CoordinatorHomeScreenState();
}

class _CoordinatorHomeScreenState extends State<CoordinatorHomeScreen> {
  int tab = 0;
  final tabs = const ['Jadwal', 'Checklist', 'Laporan'];
  final rooms = const ['Kamar Mandi Kompleks', 'Kamar A', 'Kamar B'];

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 10),
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
                    'Captain!',
                    style: TextStyle(
                      color: DutioPalette.of(context).accent,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                '/notifications',
                arguments: DutioRole.coordinator,
              ),
              icon: const Icon(Icons.notifications_none_rounded),
            ),
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                '/settings',
                arguments: DutioRole.coordinator,
              ),
              icon: const Icon(Icons.person_outline_rounded),
            ),
          ],
        ),
      ),
      Container(
        color: DutioPalette.of(context).sage,
        padding: const EdgeInsets.symmetric(vertical: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _shortcut(
              context,
              Icons.manage_search_rounded,
              'Data Center',
              '/coordinator/data',
            ),
            _shortcut(
              context,
              Icons.bar_chart_rounded,
              'Evaluasi',
              '/coordinator/evaluation',
            ),
            _shortcut(
              context,
              Icons.settings_rounded,
              'Pengaturan',
              '/settings',
              arguments: DutioRole.coordinator,
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          decoration: BoxDecoration(
            color: DutioPalette.of(context).background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            children: [
              const DutioSectionTitle('Yuk Pantau Crew!'),
              const SizedBox(height: 10),
              Row(
                children: List.generate(tabs.length, (index) {
                  final active = tab == index;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: InkWell(
                        onTap: () => setState(() => tab = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            color: active
                                ? DutioPalette.of(context).mutedSurface
                                : DutioPalette.of(context).inactiveSurface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tabs[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: active
                                  ? DutioPalette.of(context).onMutedSurface
                                  : DutioPalette.of(context).secondaryText,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: DutioPalette.of(context).mutedSurface,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(14),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 4),
                        child: Text(
                          tab == 0
                              ? 'Berikut jadwal piket hari ini'
                              : tab == 1
                              ? 'Progress checklist crew'
                              : 'Tinjau laporan piket terbaru',
                          style: TextStyle(
                            color: DutioPalette.of(context).onMutedSurface,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      for (var index = 0; index < rooms.length; index++)
                        _crewCard(context, index),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _shortcut(
    BuildContext context,
    IconData icon,
    String title,
    String route, {
    Object? arguments,
  }) => InkWell(
    onTap: () => Navigator.pushNamed(context, route, arguments: arguments),
    borderRadius: BorderRadius.circular(22),
    child: Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: DutioPalette.of(context).background,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Icon(
            icon,
            color: DutioPalette.of(context).textStrong,
            size: 38,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            color: DutioPalette.of(context).onAccent,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );

  Widget _crewCard(BuildContext context, int index) {
    final title = tab == 2
        ? 'Laporan piket • Kamar ${String.fromCharCode(65 + index)}'
        : rooms[index];
    final subtitle = tab == 0
        ? 'Lantai ${index + 1}  •  ${index == 0 ? '07.00 – 09.00' : '09.00 – 11.00'}'
        : tab == 1
        ? '${index + 1}/4 tugas selesai'
        : 'Menunggu evaluasi koordinator';
    return InkWell(
      onTap: tab == 2
          ? () => Navigator.pushNamed(context, '/coordinator/report-detail')
          : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        constraints: const BoxConstraints(minHeight: 100),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: DutioPalette.of(context).surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: DutioPalette.of(context).secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: index == 0
                    ? DutioPalette.of(context).action
                    : DutioPalette.of(context).blush,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                tab == 2
                    ? 'Kamar ${String.fromCharCode(65 + index)}'
                    : 'Kamar A',
                style: TextStyle(
                  color: index == 0
                      ? DutioPalette.of(context).onAccent
                      : DutioPalette.of(context).onBlush,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
