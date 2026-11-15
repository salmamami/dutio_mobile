import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_theme.dart';
import '../widgets/dutio_widgets.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key, required this.role});

  final DutioRole role;

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final String baseUrl = 'http://127.0.0.1:8000';

  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final List<bool> obscure = [true, true, true];

  bool loading = false;

  @override
  void dispose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  // Menampilkan atau menyembunyikan password
  void toggleObscure(int index) {
    setState(() {
      obscure[index] = !obscure[index];
    });
  }

  // Mengirim perubahan password ke API
  Future<void> updatePassword() async {
    if (currentPassword.text.isEmpty ||
        newPassword.text.isEmpty ||
        confirmPassword.text.isEmpty) {
      showMessage('Semua kolom password wajib diisi.');
      return;
    }

    if (newPassword.text.length < 8) {
      showMessage('Password baru minimal 8 karakter.');
      return;
    }

    if (newPassword.text != confirmPassword.text) {
      showMessage('Konfirmasi password tidak sama.');
      return;
    }

    if (currentPassword.text == newPassword.text) {
      showMessage('Password baru harus berbeda dari password lama.');
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        throw Exception('Token login tidak ditemukan. Silakan login kembali.');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/change-password'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'current_password': currentPassword.text,
          'new_password': newPassword.text,
          'new_password_confirmation': confirmPassword.text,
        }),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        if (!mounted) return;

        setState(() {
          currentPassword.clear();
          newPassword.clear();
          confirmPassword.clear();
          loading = false;
        });

        showMessage(result['message'] ?? 'Password berhasil diperbarui!');
      } else {
        String message = result['message'] ?? 'Gagal mengubah password.';

        // Mengambil pesan validasi dari Laravel
        if (result['errors'] is Map) {
          final errors = result['errors'] as Map;
          if (errors.isNotEmpty) {
            final firstError = errors.values.first;
            if (firstError is List && firstError.isNotEmpty) {
              message = firstError.first.toString();
            }
          }
        }

        throw Exception(message);
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      showMessage(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  // Menampilkan pesan
  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

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
              color: DutioPalette.of(context).surfaceVariant,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shield_outlined,
                  color: DutioPalette.of(context).accent,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Pastikan keamanan akunmu ya',
                    style: TextStyle(
                      color: DutioPalette.of(context).accent,
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
                color: DutioPalette.of(context).sage,
                borderRadius: BorderRadius.circular(24),
              ),
              child: ListView(
                children: [
                  _passwordField('Password Lama', currentPassword, 0),

                  const SizedBox(height: 12),

                  _passwordField('Password Baru', newPassword, 1),

                  const SizedBox(height: 12),

                  _passwordField('Konfirmasi Password', confirmPassword, 2),

                  const SizedBox(height: 20),

                  DutioPrimaryButton(
                    label: loading ? 'Memproses...' : 'Ubah password',
                    icon: Icons.check_rounded,
                    onPressed: loading ? null : updatePassword,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Widget input password
  Widget _passwordField(
    String label,
    TextEditingController controller,
    int index,
  ) => TextField(
    controller: controller,
    obscureText: obscure[index],
    enabled: !loading,
    decoration: InputDecoration(
      labelText: label,
      hintText: 'Minimal 8 karakter',
      suffixIcon: IconButton(
        onPressed: () => toggleObscure(index),
        icon: Icon(obscure[index] ? Icons.visibility_off : Icons.visibility),
      ),
    ),
  );
}
