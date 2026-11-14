import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class DataCenterScreen extends StatelessWidget {
  const DataCenterScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const DutioHeader(
            title: 'Data Center',
            subtitle: 'Atur area dan kamar asrama',
            showBack: true,
          ),
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: DutioPalette.of(context).surfaceVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: DutioPalette.of(context).accent,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Kelola data kamar dan area piket pada satu tempat.',
                    style: TextStyle(color: DutioPalette.of(context).accent),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                _statCard(context, '32', 'Kamar', Icons.meeting_room_outlined),
                const SizedBox(width: 12),
                _statCard(
                  context,
                  '16',
                  'Area Piket',
                  Icons.cleaning_services_outlined,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: [
                const DutioSectionTitle('Kelola Data'),
                const SizedBox(height: 12),
                _routeCard(
                  context,
                  Icons.cleaning_services_rounded,
                  'Area Piket',
                  'Tambah atau ubah area tugas piket',
                  '/coordinator/areas',
                ),
                const SizedBox(height: 12),
                _routeCard(
                  context,
                  Icons.meeting_room_rounded,
                  'Kamar',
                  'Atur kamar dan kelompok asrama',
                  '/coordinator/rooms',
                ),
                const SizedBox(height: 12),
                _routeCard(
                  context,
                  Icons.people_alt_outlined,
                  'Anggota',
                  'Data anggota terdaftar',
                  '/coordinator/rooms',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _statCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DutioPalette.of(context).surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: DutioPalette.of(context).blush,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: DutioPalette.of(context).accent, size: 28),
          Text(
            value,
            style: TextStyle(
              color: DutioPalette.of(context).accent,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    ),
  );

  Widget _routeCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String route,
  ) => DutioPanel(
    padding: EdgeInsets.zero,
    child: ListTile(
      onTap: () => Navigator.pushNamed(context, route),
      leading: CircleAvatar(
        backgroundColor: DutioPalette.of(context).surfaceVariant,
        child: Icon(icon, color: DutioPalette.of(context).accent),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
    ),
  );
}
