import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class AreaManagementScreen extends StatefulWidget {
  const AreaManagementScreen({super.key});

  @override
  State<AreaManagementScreen> createState() => _AreaManagementScreenState();
}

class _AreaManagementScreenState extends State<AreaManagementScreen> {
  final areas = <String>[
    'Kamar Mandi Kompleks',
    'Gazebo',
    'Jemuran',
    'Ruang Bersama',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const DutioHeader(title: 'Area Piket', showBack: true),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: DutioPalette.of(context).mutedSurface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: ListView(
                children: [
                  Text(
                    'Daftar area tugas',
                    style: TextStyle(
                      color: DutioPalette.of(context).onMutedSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final (index, area) in areas.indexed)
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: DutioPalette.of(context).surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: DutioPalette.of(context)
                              .surfaceVariant,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(
                          area,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text('Lantai ${index + 1}'),
                        trailing: IconButton(
                          onPressed: () =>
                              setState(() => areas.removeAt(index)),
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: DutioPalette.of(context).secondaryText,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 6),
                  DutioPrimaryButton(
                    label: 'Tambah Area',
                    icon: Icons.add_rounded,
                    onPressed: _addArea,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Future<void> _addArea() async {
    final controller = TextEditingController();
    final value = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah area piket'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Nama area'),
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
      setState(() => areas.add(value));
    }
  }
}
