import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/dutio_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final email = TextEditingController();
  bool codeSent = false;

  DutioRole get role {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return arguments is DutioRole ? arguments : DutioRole.member;
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const DutioHeader(
            title: 'Lupa Password ya?',
            subtitle: 'Verifikasi lewat email atau nomor telepon',
            showBack: true,
          ),
          const SizedBox(height: 42),
          const Icon(
            Icons.mark_email_read_outlined,
            color: AppTheme.darkGreen,
            size: 74,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email atau nomor telepon',
            ),
          ),
          const SizedBox(height: 14),
          if (codeSent)
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Masukkan kode verifikasi'),
            ),
          if (codeSent) const SizedBox(height: 14),
          DutioPrimaryButton(
            label: codeSent ? 'Verifikasi kode' : 'Kirim kode',
            icon: Icons.send_rounded,
            onPressed: () {
              if (!codeSent) {
                setState(() => codeSent = true);
              } else {
                Navigator.pushNamed(context, '/password', arguments: role);
              }
            },
          ),
          const SizedBox(height: 12),
          if (codeSent)
            TextButton(
              onPressed: () => setState(() => codeSent = false),
              child: const Text('Kirim ulang kode'),
            ),
        ],
      ),
    ),
  );
}
