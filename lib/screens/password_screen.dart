import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/dutio_widgets.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key, required this.role});

  final DutioRole role;

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const DutioHeader(title: 'Password', showBack: true),
          Container(
            margin: const EdgeInsets.fromLTRB(18, 16, 18, 0),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.lightGreen,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(Icons.shield_outlined, color: AppTheme.darkGreen),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Pastikan keamanan akunmu ya',
                    style: TextStyle(
                      color: AppTheme.darkGreen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(18),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.sage,
                borderRadius: BorderRadius.circular(24),
              ),
              child: ListView(
                children: [
                  _passwordField('Password Lama'),
                  const SizedBox(height: 12),
                  _passwordField('Password Baru'),
                  const SizedBox(height: 12),
                  _passwordField('Konfirmasi Password'),
                  const SizedBox(height: 20),
                  DutioPrimaryButton(
                    label: 'Ubah password',
                    icon: Icons.check_rounded,
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Perubahan password tersimpan pada prototipe UI.',
                        ),
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

  Widget _passwordField(String label) => TextField(
    obscureText: obscure,
    decoration: InputDecoration(
      labelText: label,
      hintText: 'Minimal 8 huruf',
      suffixIcon: IconButton(
        onPressed: () => setState(() => obscure = !obscure),
        icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
      ),
    ),
  );
}
