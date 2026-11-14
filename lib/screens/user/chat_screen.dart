import 'package:flutter/material.dart';

import '../../core/app_theme.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({super.key});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final controller = TextEditingController();
  final messages = <(String, bool)>[
    ('Halo, jadwal piket kamar mandi hari ini jam berapa?', true),
    ('Piket dimulai pukul 07.00 ya. Jangan lupa checklist tugasnya.', false),
    ('Siap, terima kasih!', true),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppTheme.cream,
    body: SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 16, 10),
            decoration: const BoxDecoration(
              color: AppTheme.cream,
              boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 4)],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppTheme.darkGreen,
                  child: Icon(Icons.person, color: AppTheme.white),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Koordinator',
                    style: TextStyle(
                      color: AppTheme.darkGreen,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Memanggil Koordinator'),
                      content: const Text(
                        'Fitur panggilan tersedia setelah integrasi layanan.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Tutup'),
                        ),
                      ],
                    ),
                  ),
                  icon: const Icon(
                    Icons.call_outlined,
                    color: AppTheme.darkGreen,
                  ),
                ),
                const Icon(
                  Icons.person_outline_rounded,
                  color: AppTheme.darkGreen,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message.$2
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 280),
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: message.$2 ? AppTheme.sage : AppTheme.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft: Radius.circular(message.$2 ? 18 : 4),
                        bottomRight: Radius.circular(message.$2 ? 4 : 18),
                      ),
                      boxShadow: const [
                        BoxShadow(color: Color(0x18000000), blurRadius: 3),
                      ],
                    ),
                    child: Text(
                      message.$1,
                      style: TextStyle(
                        color: message.$2 ? AppTheme.white : AppTheme.dark,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lampiran tersedia setelah API terhubung.'),
                    ),
                  ),
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: AppTheme.darkGreen,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Kirim pesan',
                      filled: true,
                      fillColor: AppTheme.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {
                    final value = controller.text.trim();
                    if (value.isEmpty) return;
                    setState(() {
                      messages.add((value, true));
                      controller.clear();
                    });
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.darkGreen,
                  ),
                  icon: const Icon(Icons.send_rounded, color: AppTheme.white),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
