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
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
        child: Row(
          children: [
            const Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Crew\n',
                      style: TextStyle(color: AppTheme.white),
                    ),
                    TextSpan(
                      text: 'Points',
                      style: TextStyle(color: Color(0xFFFFD18B)),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                  height: .95,
                ),
              ),
            ),
            const DutioLogo(size: 36),
          ],
        ),
      ),
      Expanded(
        child: Stack(
          children: [
            Container(
              color: AppTheme.sage,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 12, 150, 0),
                  child: Text(
                    'Setiap aktivitas piket yang valid akan tercatat sebagai poin di sini.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.white.withValues(alpha: .92),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 14,
              child: Container(
                width: 126,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(color: Color(0xFFFFD18B), offset: Offset(0, 7)),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      '8',
                      style: TextStyle(
                        color: AppTheme.charcoal,
                        fontSize: 44,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.cream,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Total Poin',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 72,
              child: Icon(
                Icons.assignment_turned_in_rounded,
                size: 96,
                color: const Color(0xFFFFD18B),
              ),
            ),
            Positioned.fill(
              top: 208,
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 26, 14, 14),
                decoration: const BoxDecoration(
                  color: AppTheme.cream,
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
                          color: AppTheme.charcoal,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListView(
                          children: evaluations
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
                                  DutioPanel(
                                    color: AppTheme.white,
                                    child: const Text(
                                      'Piket terakhir • Kamar mandi kompleks\nDinilai baik oleh koordinator',
                                      style: TextStyle(height: 1.5),
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
          color: active ? AppTheme.charcoal : const Color(0xFFF1EADF),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: active ? AppTheme.white : AppTheme.charcoal),
        ),
      ),
    ),
  );

  Widget _pointRow(String point, String detail, Color badge) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppTheme.white,
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
