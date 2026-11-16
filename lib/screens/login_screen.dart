import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_theme.dart';
import '../widgets/dutio_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DutioRole role = DutioRole.member;
  final username = TextEditingController();
  final password = TextEditingController();

  bool hidePassword = true;
  bool isLoading = false;

  // Alamat backend Laravel untuk Flutter Web
  final String baseUrl = 'http://192.168.2.184:8000/api';

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  // Fungsi untuk menampilkan pesan
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Fungsi login ke Laravel API
  Future<void> signIn() async {
    final email = username.text.trim();
    final passwordText = password.text;

    if (email.isEmpty || passwordText.isEmpty) {
      showMessage('Email dan password wajib diisi!');
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': passwordText,
        }),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          result['success'] == true) {
        final user = result['user'];
        final token = result['token'];

        if (user == null || token == null) {
          throw Exception(
            'Data pengguna atau token tidak ditemukan.',
          );
        }

        // Memastikan role sesuai pilihan pengguna
        final userRole = user['role'];

        final expectedRole =
            role == DutioRole.member ? 'penghuni' : 'koordinator';

        if (userRole != expectedRole) {
          showMessage(
            'Akun ini tidak terdaftar sebagai '
            '${role == DutioRole.member ? 'Anggota' : 'Koordinator'}.',
          );
          return;
        }

        // Menyimpan token dan informasi pengguna
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('auth_token', token.toString());
        await prefs.setString('user_role', userRole.toString());
        await prefs.setString('user_name', user['name'].toString());
        await prefs.setString('user_email', user['email'].toString());

        if (!mounted) return;

        showMessage('Login berhasil! Selamat datang di DUTIO.');

        // Mengarahkan pengguna sesuai role
        Navigator.pushReplacementNamed(
          context,
          userRole == 'penghuni' ? '/user' : '/coordinator',
        );
      } else {
        showMessage(
          result['message'] ?? 'Login gagal. Periksa kembali data kamu.',
        );
      }
    } catch (e) {
      showMessage('Gagal menghubungi server: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(26, 22, 26, 28),
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: DutioLogo(size: 44),
              ),
              const SizedBox(height: 80),
              Text(
                role == DutioRole.member
                    ? "Crew, Let's Move!"
                    : 'Captain on Deck!',
                style: TextStyle(
                  color: DutioPalette.of(context).accent,
                  fontSize: 29,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                role == DutioRole.member
                    ? 'Piket hari ini dimulai dari sini 🚀'
                    : 'Jalankan kendali, buat semuanya teratur ⚙️',
                style: TextStyle(
                  color: DutioPalette.of(context).textPrimary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 130),
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.sizeOf(context).height * .58,
                ),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                decoration: BoxDecoration(
                  color: DutioPalette.of(context).sage,
                  borderRadius: BorderRadius.circular(38),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: DutioPalette.of(context).textStrong,
                        fontSize: 39,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SegmentedButton<DutioRole>(
                      segments: const [
                        ButtonSegment(
                          value: DutioRole.member,
                          label: Text('Anggota'),
                        ),
                        ButtonSegment(
                          value: DutioRole.coordinator,
                          label: Text('Koordinator'),
                        ),
                      ],
                      selected: {role},
                      onSelectionChanged: isLoading
                          ? null
                          : (value) => setState(
                                () => role = value.first,
                              ),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith(
                          (states) =>
                              states.contains(WidgetState.selected)
                                  ? DutioPalette.of(context).background
                                  : DutioPalette.of(context).sage,
                        ),
                        foregroundColor: WidgetStateProperty.all(
                          DutioPalette.of(context).accent,
                        ),
                      ),
                    ),
                    _input(
                      'Username atau email',
                      controller: username,
                    ),
                    _input(
                      'Password',
                      controller: password,
                      obscureText: hidePassword,
                      suffix: IconButton(
                        onPressed: () => setState(
                          () => hidePassword = !hidePassword,
                        ),
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/forgot-password',
                          arguments: role,
                        ),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: AppTheme.white),
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: isLoading ? null : signIn,
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            DutioPalette.of(context).action,
                        foregroundColor:
                            DutioPalette.of(context).onAccent,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        shape: const StadiumBorder(),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppTheme.white,
                              ),
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                    if (role == DutioRole.coordinator) ...[
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/signup',
                        ),
                        child: const Text(
                          'Become the Captain!  Sign Up',
                          style: TextStyle(color: AppTheme.white),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _input(
    String hint, {
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffix,
  }) =>
      TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          color: DutioPalette.of(context).textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: DutioPalette.of(context)
                .textPrimary
                .withValues(alpha: .7),
          ),
          suffixIcon: suffix,
          fillColor: DutioPalette.of(context).surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: DutioPalette.of(context).border,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: DutioPalette.of(context).accent,
              width: 1.5,
            ),
          ),
        ),
      );
}
