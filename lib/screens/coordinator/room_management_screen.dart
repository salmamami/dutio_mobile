import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class RoomManagementScreen extends StatefulWidget {
  const RoomManagementScreen({super.key});

  @override
  State<RoomManagementScreen> createState() => _RoomManagementScreenState();
}

class _RoomManagementScreenState extends State<RoomManagementScreen> {
  final rooms = <String>['KAMAR A', 'KAMAR B', 'KAMAR C', 'KAMAR D'];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const DutioHeader(title: 'Kamar', showBack: true),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final filter in [
                  'Kamar A',
                  'Kamar B',
                  'Kamar C',
                  'Kamar D',
                ])
                  Chip(
                    label: Text(filter),
                    backgroundColor: DutioPalette.of(context).surfaceVariant,
                    side: BorderSide.none,
                  ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: DutioPalette.of(context).mutedSurface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        for (final (index, room) in rooms.indexed)
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: DutioPalette.of(context).surface,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.meeting_room_outlined,
                                color: DutioPalette.of(context).accent,
                              ),
                              title: Text(
                                room,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              subtitle: Text('${24 + index} anggota'),
                              trailing: IconButton(
                                onPressed: () =>
                                    setState(() => rooms.removeAt(index)),
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  DutioPrimaryButton(
                    label: 'Tambah Kamar',
                    icon: Icons.add_rounded,
                    onPressed: _addRoom,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Future<void> _addRoom() async {
    final controller = TextEditingController();
    final value = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah kamar'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Nama kamar'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (value != null && value.isNotEmpty && mounted) {
      setState(() => rooms.add(value.toUpperCase()));
    }
  }
}
