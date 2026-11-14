import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class EvaluationScreen extends StatefulWidget {
  const EvaluationScreen({super.key});

  @override
  State<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  int selectedTab = 0;
  int category = 0;

  List<String> get tabs => category == 0
      ? const ['Menunggu dievaluasi', 'Sudah dievaluasi', 'Riwayat Laporan']
      : const ['Menunggu dinilai', 'Sudah dinilai'];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const DutioHeader(
            title: 'Evaluasi',
            showBack: true,
            trailing: Icon(
              Icons.notifications_none_rounded,
              color: AppTheme.darkGreen,
            ),
          ),
          if (selectedTab == 0) _performance(),
          Container(
            margin: const EdgeInsets.fromLTRB(14, 14, 14, 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.lightGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.fact_check_outlined,
                  color: AppTheme.darkGreen,
                  size: 28,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tinjau hasil pelaksanaan piket dan berikan penilaian untuk setiap crew.',
                    style: TextStyle(fontSize: 12, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              decoration: const BoxDecoration(
                color: AppTheme.cream,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Yuk Pantau Crew!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 56,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: tabs.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 7),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => setState(() => selectedTab = index),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 110,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: selectedTab == index
                                ? AppTheme.charcoal
                                : const Color(0xFFF0EAE0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tabs[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selectedTab == index
                                  ? AppTheme.white
                                  : AppTheme.charcoal,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.charcoal,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.all(14),
                        children: [
                          if (selectedTab == 0)
                            for (var index = 0; index < 3; index++)
                              _reportCard(context, index),
                          if (selectedTab == 1)
                            for (var index = 0; index < 3; index++)
                              _reportCard(context, index, done: true),
                          if (selectedTab == 2 && category == 0)
                            _history(context),
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
  );

  Widget _performance() => Container(
    width: double.infinity,
    color: AppTheme.sage,
    padding: const EdgeInsets.fromLTRB(24, 14, 24, 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Crew Performance',
          style: TextStyle(
            color: AppTheme.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _scoreCircle('7', '20', 'Laporan Masuk'),
            const SizedBox(width: 18),
            _scoreCircle('20', '70', 'Mission Selesai'),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _categoryButton(
              Icons.fact_check_outlined,
              'Laporan',
              category == 0,
              () => setState(() {
                category = 0;
                selectedTab = 0;
              }),
            ),
            const SizedBox(width: 10),
            _categoryButton(
              Icons.checklist_rounded,
              'Mission',
              category == 1,
              () => setState(() {
                category = 1;
                selectedTab = 0;
              }),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _categoryButton(
    IconData icon,
    String label,
    bool active,
    VoidCallback onTap,
  ) => Expanded(
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: active ? AppTheme.darkGreen : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppTheme.darkGreen),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    ),
  );

  Widget _scoreCircle(String value, String total, String label) => Expanded(
    child: Container(
      height: 132,
      decoration: BoxDecoration(
        color: AppTheme.cream,
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.white, width: 7),
        boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$value/',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: total,
                  style: const TextStyle(
                    color: AppTheme.charcoal,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(width: 100, height: 1, color: AppTheme.sage),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _reportCard(BuildContext context, int index, {bool done = false}) {
    final title = category == 1
        ? const [
            'Menyapu lantai kamar mandi',
            'Membersihkan wastafel',
            'Menyikat kloset',
          ][index]
        : index == 0
        ? 'Kamar Mandi Kompleks'
        : index == 1
        ? 'Cuci Tempat Sampah'
        : 'Jemuran';
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/coordinator/report-detail',
        arguments: category == 1,
      ),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    category == 1
                        ? 'Kamar ${String.fromCharCode(65 + index)}'
                        : index == 0
                        ? 'Lantai 1'
                        : 'Lantai ${index + 1}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    done ? 'Sudah dievaluasi' : 'Ketuk untuk melihat laporan',
                    style: const TextStyle(
                      color: AppTheme.charcoal,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: done ? AppTheme.sage : AppTheme.blush,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                'Kamar ${String.fromCharCode(65 + index)}',
                style: const TextStyle(color: AppTheme.white, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _history(BuildContext context) => Column(
    children: [
      Row(
        children: [
          TextButton(
            onPressed: () => setState(() => selectedTab = 0),
            child: const Text('« back'),
          ),
          const Spacer(),
          const Text(
            'SEMUA KAMAR',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ],
      ),
      for (final (title, room) in [
        ('Kamar Mandi Kompleks', 'Kamar A'),
        ('Cuci Tempat Sampah', 'Kamar B'),
        ('Jemuran', 'Kamar C'),
      ])
        Container(
          margin: const EdgeInsets.only(bottom: 9),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    Text(room),
                  ],
                ),
              ),
              const Text(
                '11-04-2025',
                style: TextStyle(color: AppTheme.charcoal, fontSize: 11),
              ),
            ],
          ),
        ),
    ],
  );
}
