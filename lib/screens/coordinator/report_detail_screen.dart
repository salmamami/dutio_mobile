import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class ReportDetailScreen extends StatefulWidget {
  const ReportDetailScreen({super.key, this.isMission = false});

  final bool isMission;

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  int rating = 0;
  final feedback = TextEditingController();

  @override
  void dispose() {
    feedback.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          DutioHeader(
            title: widget.isMission ? 'Evaluasi Mission' : 'Laporan',
            showBack: true,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                DutioPanel(
                  color: AppTheme.lightGreen,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.task_alt_rounded,
                        color: AppTheme.darkGreen,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.isMission
                              ? 'Tinjau progres mission dan berikan penilaian.'
                              : 'Laporan tugas piket sudah dikirim crew.',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (widget.isMission)
                  const DutioPanel(
                    color: AppTheme.lightGreen,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mission Cleanliness',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('✓  Menyapu lantai kamar mandi'),
                        Text('✓  Membersihkan wastafel'),
                        Text('○  Menyikat kloset'),
                      ],
                    ),
                  )
                else
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/bathroom.png',
                      height: 260,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  widget.isMission ? 'Mission Kamar A' : 'Kamar Mandi Kompleks',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const Text('Lantai 1  •  Kamar A  •  11-04-2025'),
                const SizedBox(height: 18),
                Text(
                  widget.isMission ? 'Penilaian Mission' : 'Penilaian Crew',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      onPressed: () => setState(() => rating = index + 1),
                      icon: Icon(
                        index < rating
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: const Color(0xFFE7AF45),
                        size: 32,
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: feedback,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Catatan untuk crew',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 18),
                DutioPrimaryButton(
                  label: widget.isMission
                      ? 'Simpan penilaian mission'
                      : 'Simpan evaluasi',
                  icon: Icons.check_rounded,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Evaluasi disimpan pada prototipe UI.'),
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
