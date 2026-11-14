import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/dutio_widgets.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key, required this.role});

  final DutioRole role;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool editing = false;
  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController phone;

  @override
  void initState() {
    super.initState();
    final isMember = widget.role == DutioRole.member;
    name = TextEditingController(text: isMember ? 'Kamar A' : 'Koordinator');
    email = TextEditingController(
      text: isMember ? 'kamarA@gmail.com' : 'koordinator@dutio.id',
    );
    phone = TextEditingController(text: '08567890100');
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          DutioHeader(
            title: 'Account',
            showBack: true,
            trailing: IconButton(
              onPressed: () => setState(() => editing = !editing),
              icon: Icon(editing ? Icons.close_rounded : Icons.edit_outlined),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(18),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.sage,
                borderRadius: BorderRadius.circular(26),
              ),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGreen,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text(
                      'Kelola Akunmu yuk!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.darkGreen,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _field('Nama Pengguna', name),
                  const SizedBox(height: 10),
                  _field('Email', email),
                  const SizedBox(height: 10),
                  _field('Nomor Telepon', phone),
                  if (editing) ...[
                    const SizedBox(height: 16),
                    DutioPrimaryButton(
                      label: 'Simpan perubahan',
                      icon: Icons.check_rounded,
                      onPressed: () {
                        setState(() => editing = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Perubahan disimpan di prototipe.'),
                          ),
                        );
                      },
                    ),
                  ],
                  const SizedBox(height: 18),
                  OutlinedButton.icon(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text('Logout'),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppTheme.white,
                      foregroundColor: AppTheme.darkGreen,
                      padding: const EdgeInsets.symmetric(vertical: 14),
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

  Widget _field(String label, TextEditingController controller) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: AppTheme.ink,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 5),
      TextField(
        controller: controller,
        readOnly: !editing,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.white,
          suffixIcon: editing
              ? const Icon(Icons.edit_outlined, color: AppTheme.sage)
              : null,
        ),
      ),
    ],
  );
}
