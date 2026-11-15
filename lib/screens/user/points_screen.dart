import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class UserPointsScreen extends StatefulWidget {
  const UserPointsScreen({super.key});

  @override
  State<UserPointsScreen> createState() => _UserPointsScreenState();
}

class _UserPointsScreenState extends State<UserPointsScreen> {
  bool evaluations = false;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: Stack(
          children: [
            Container(color: DutioPalette.of(context).sage),
            Positioned(
              top: 12,
              left: 20,
              right: 20,
              height: 180,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Crew Points',
                          style: TextStyle(
                            color: DutioPalette.of(context).onAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Informasi poin',
                        onPressed: () => showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Tentang poin'),
                            content: const Text(
                              'Aktivitas piket yang valid akan tercatat sebagai poin.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Mengerti'),
                              ),
                            ],
                          ),
                        ),
                        icon: Icon(
                          Icons.info_outline_rounded,
                          color: DutioPalette.of(context).onAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: DutioPalette.of(context).surface,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .10),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '8',
                                  style: TextStyle(
                                    color: DutioPalette.of(context).textPrimary,
                                    fontSize: 40,
                                    height: 1,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Total Poin',
                                  style: TextStyle(
                                    color: DutioPalette.of(context)
                                        .secondaryText,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: DutioPalette.of(context).surfaceVariant,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.verified_rounded,
                                    color: DutioPalette.of(context).accent,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Piket terakhir',
                                          style: TextStyle(
                                            color: DutioPalette.of(context)
                                                .textPrimary,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Dinilai baik',
                                          style: TextStyle(
                                            color: DutioPalette.of(context)
                                                .secondaryText,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
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
            ),
            Positioned.fill(
              top: 208,
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 26, 14, 14),
                decoration: BoxDecoration(
                  color: DutioPalette.of(context).background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _tab(
                          'Poin',
                          !evaluations,
                          () => setState(() => evaluations = false),
                        ),
                        const SizedBox(width: 8),
                        _tab(
                          'Evaluasi Piket',
                          evaluations,
                          () => setState(() => evaluations = true),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: DutioPalette.of(context).mutedSurface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListView(
                          children: !evaluations
                              ? [
                                  _pointRow(
                                    '+8',
                                    'Kebersihan dinilai baik',
                                    const Color(0xFF98C888),
                                  ),
                                  _pointRow(
                                    '+5',
                                    'Piket selesai tepat waktu',
                                    const Color(0xFF98C888),
                                  ),
                                  _pointRow(
                                    '-5',
                                    'Tidak melengkapi mission',
                                    const Color(0xFFDC9789),
                                  ),
                                ]
                              : [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: DutioPanel(
                                      color: DutioPalette.of(context).surface,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Piket terakhir • Kamar mandi kompleks',
                                                  style: TextStyle(
                                                    color: DutioPalette.of(
                                                      context,
                                                    ).textPrimary,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Dinilai baik oleh koordinator',
                                                  style: TextStyle(
                                                    color: DutioPalette.of(
                                                      context,
                                                    ).secondaryText,
                                                    height: 1.4,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 24,
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.history_toggle_off_rounded,
                                          size: 38,
                                          color: DutioPalette.of(context)
                                              .secondaryText,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Evaluasi piket berikutnya akan muncul setelah penilaian selanjutnya.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: DutioPalette.of(context)
                                                .secondaryText,
                                            fontSize: 12,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
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
      ),
    ],
  );

  Widget _tab(String label, bool active, VoidCallback onTap) => Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active
              ? DutioPalette.of(context).mutedSurface
              : DutioPalette.of(context).pointsInactiveSurface,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: active
                ? DutioPalette.of(context).onMutedSurface
                : DutioPalette.of(context).secondaryText,
          ),
        ),
      ),
    ),
  );

  Widget _pointRow(String point, String detail, Color badge) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: DutioPalette.of(context).surface,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          decoration: BoxDecoration(
            color: badge,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            point,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(detail, style: const TextStyle(fontSize: 13))),
      ],
    ),
  );
}
