import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class CoordinatorChatScreen extends StatefulWidget {
  const CoordinatorChatScreen({super.key});

  @override
  State<CoordinatorChatScreen> createState() => _CoordinatorChatScreenState();
}

class _CoordinatorChatScreenState extends State<CoordinatorChatScreen> {
  String? selectedRoom;
  final controller = TextEditingController();
  final messages = <(String, bool)>[
    ('Halo, jadwal piket Kamar A sudah diumumkan ya.', false),
    ('Baik Kak, terima kasih!', true),
    ('Mohon kirim laporan setelah selesai.', false),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final room = selectedRoom;
    return Scaffold(
      backgroundColor: DutioPalette.of(context).background,
      body: SafeArea(
        child: Column(
          children: [
            if (room == null) _listHeader() else _chatHeader(room),
            if (room == null)
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(14),
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search_rounded),
                        fillColor: DutioPalette.of(context).surfaceVariant,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (final (name, preview) in [
                      ('Kamar A', 'Ada kendala, crew?'),
                      ('Kamar B', 'Laporan piket sudah dikirim.'),
                      ('Kamar C', 'Baik, Captain.'),
                    ])
                      ListTile(
                        onTap: () => setState(() {
                          selectedRoom = name;
                          messages.clear();
                          messages.add(('Halo, ada yang bisa dibantu?', false));
                        }),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: DutioPalette.of(context)
                              .surfaceVariant,
                          child: Icon(
                            Icons.person,
                            color: DutioPalette.of(context).accent,
                          ),
                        ),
                        title: Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(preview),
                        trailing: const Text(
                          '9:29',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                  ],
                ),
              )
            else ...[
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final item = messages[index];
                    return Align(
                      alignment: item.$2
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 285),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: item.$2
                              ? DutioPalette.of(context).sage
                              : DutioPalette.of(context).surface,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          item.$1,
                          style: TextStyle(
                            color: item.$2
                                ? AppTheme.white
                                : DutioPalette.of(context).textPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Lampiran tersedia setelah API terhubung.',
                              ),
                            ),
                          ),
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: DutioPalette.of(context).accent,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Kirim pesan',
                          fillColor: DutioPalette.of(context).surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton.filled(
                      onPressed: _sendMessage,
                      style: IconButton.styleFrom(
                        backgroundColor: DutioPalette.of(context).action,
                      ),
                      icon: const Icon(
                        Icons.send_rounded,
                        color: AppTheme.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _listHeader() => Padding(
    padding: EdgeInsets.fromLTRB(20, 16, 20, 10),
    child: Row(
      children: [
        Text(
          'Chat',
          style: TextStyle(
            color: DutioPalette.of(context).accent,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        Spacer(),
        DutioLogo(size: 32),
      ],
    ),
  );

  Widget _chatHeader(String room) => Container(
    padding: const EdgeInsets.fromLTRB(6, 8, 14, 8),
    decoration: BoxDecoration(
      color: DutioPalette.of(context).background,
      boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 4)],
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: () => setState(() => selectedRoom = null),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        CircleAvatar(
          backgroundColor: DutioPalette.of(context).surfaceVariant,
          child: Icon(Icons.person, color: DutioPalette.of(context).accent),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            room,
            style: TextStyle(
              color: DutioPalette.of(context).accent,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        IconButton(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Panggilan suara'),
              content: const Text(
                'Panggilan tersedia setelah integrasi layanan.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ],
            ),
          ),
          icon: Icon(
            Icons.call_outlined,
            color: DutioPalette.of(context).accent,
          ),
        ),
        const DutioLogo(size: 28),
      ],
    ),
  );

  void _sendMessage() {
    final value = controller.text.trim();
    if (value.isEmpty) return;
    setState(() {
      messages.add((value, true));
      controller.clear();
    });
  }
}
