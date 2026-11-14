import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/dutio_widgets.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key, required this.role});

  final DutioRole role;

  @override
  Widget build(BuildContext context) {
    final isMember = role == DutioRole.member;
    final items = isMember
        ? const [
            (
              'Deadline Hampir Habis',
              'Bersihkan area kamar mandi!',
              Icons.event_note,
            ),
            (
              'Pengingat Misi',
              'Segera selesaikan tugas piketmu.',
              Icons.cloud_upload_outlined,
            ),
            ('Koordinator', 'Ada kendala, crew?', Icons.chat_bubble_outline),
            (
              'Jadwal Hari Ini',
              'Yuk, dapat kamar mandi hari ini!',
              Icons.calendar_month,
            ),
          ]
        : const [
            (
              'Laporan Baru',
              'Foto piket dari Kamar A menunggu tinjauan.',
              Icons.assignment_outlined,
            ),
            (
              'Misi Selesai',
              'Crew Kamar B menyelesaikan checklist.',
              Icons.fact_check_outlined,
            ),
            (
              'Pesan Baru',
              'Anggota mengirim pesan.',
              Icons.chat_bubble_outline,
            ),
            (
              'Jadwal Hari Ini',
              'Jadwal piket hari ini sudah dibuat.',
              Icons.calendar_month,
            ),
          ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DutioHeader(title: 'Notifikasi', showBack: true),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return DutioPanel(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: DutioPalette.of(context)
                            .surfaceVariant,
                        child: Icon(
                          item.$3,
                          color: DutioPalette.of(context).accent,
                        ),
                      ),
                      title: Text(
                        item.$1,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(item.$2),
                      trailing: Text(
                        '1 jam lalu',
                        style: TextStyle(
                          fontSize: 10,
                          color: DutioPalette.of(context).secondaryText,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
