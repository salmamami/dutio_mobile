import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/dutio_widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const DutioHeader(
            title: 'Become the Captain!',
            subtitle: 'Ciptakan sistem piket yang lebih teratur',
            showBack: true,
          ),
          const SizedBox(height: 30),
          const Icon(
            Icons.admin_panel_settings_outlined,
            color: AppTheme.darkGreen,
            size: 68,
          ),
          const SizedBox(height: 22),
          const TextField(
            decoration: InputDecoration(hintText: 'Nama lengkap'),
          ),
          const SizedBox(height: 12),
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: 'Email atau nomor telepon'),
          ),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(hintText: 'Password')),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(hintText: 'Konfirmasi password'),
          ),
          const SizedBox(height: 18),
          DutioPrimaryButton(
            label: 'Sign Up',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/coordinator'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Akun contoh untuk prototipe UI. Pendaftaran akan tersambung ke API pada tahap berikutnya.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppTheme.charcoal),
          ),
        ],
      ),
    ),
  );
}
