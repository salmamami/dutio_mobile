import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_theme.dart';
import '../widgets/dutio_widgets.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key, required this.role});

  final DutioRole role;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final String baseUrl = 'http://192.168.2.184:8000';

  bool editing = false;
  bool loading = true;
  bool saving = false;
  bool loggingOut = false;

  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController phone;

  String originalName = '';
  String originalEmail = '';

  @override
  void initState() {
    super.initState();

    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController(text: 'Belum tersedia');

    loadProfile();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  // Mengambil data profil dari API
  Future<void> loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        throw Exception('Token login tidak ditemukan. Silakan login kembali.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        final user = result['user'];

        if (!mounted) return;

        setState(() {
          name.text = user['name'] ?? '';
          email.text = user['email'] ?? '';

          originalName = name.text;
          originalEmail = email.text;

          loading = false;
        });

        await prefs.setString('user_name', name.text);
        await prefs.setString('user_email', email.text);
      } else {
        throw Exception(result['message'] ?? 'Gagal mengambil data profil.');
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal memuat profil: $e')));
    }
  }

  // Mengaktifkan atau membatalkan mode edit
  void toggleEditing() {
    setState(() {
      if (editing) {
        name.text = originalName;
        email.text = originalEmail;
        editing = false;
      } else {
        editing = true;
      }
    });
  }

  // Menyimpan perubahan profil ke API
  Future<void> updateProfile() async {
    if (name.text.trim().isEmpty || email.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan email tidak boleh kosong.')),
      );
      return;
    }

    setState(() {
      saving = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        throw Exception('Token login tidak ditemukan.');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/api/profile'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name.text.trim(),
          'email': email.text.trim(),
        }),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        final user = result['user'];

        await prefs.setString('user_name', user['name'] ?? '');
        await prefs.setString('user_email', user['email'] ?? '');

        if (!mounted) return;

        setState(() {
          name.text = user['name'] ?? '';
          email.text = user['email'] ?? '';

          originalName = name.text;
          originalEmail = email.text;

          editing = false;
          saving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Profil berhasil diperbarui!'),
          ),
        );
      } else {
        throw Exception(result['message'] ?? 'Gagal memperbarui profil.');
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        saving = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan perubahan: $e')));
    }
  }

  // Logout melalui API
  Future<void> logout() async {
    setState(() {
      loggingOut = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token != null && token.isNotEmpty) {
        await http.post(
          Uri.parse('$baseUrl/api/logout'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      }
    } catch (e) {
      debugPrint('Logout API gagal: $e');
    }

    // Hapus data login dari perangkat
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('auth_token');
    await prefs.remove('user_role');
    await prefs.remove('user_name');
    await prefs.remove('user_email');

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
              onPressed: loading || saving ? null : toggleEditing,
              icon: Icon(editing ? Icons.close_rounded : Icons.edit_outlined),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(18),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: DutioPalette.of(context).sage,
                borderRadius: BorderRadius.circular(26),
              ),
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: DutioPalette.of(context).surfaceVariant,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            'Kelola Akunmu yuk!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: DutioPalette.of(context).accent,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        _field('Nama Pengguna', name),

                        const SizedBox(height: 10),

                        _field('Email', email),

                        const SizedBox(height: 10),

                        _field('Nomor Telepon', phone, readOnly: true),

                        if (editing) ...[
                          const SizedBox(height: 16),
                          DutioPrimaryButton(
                            label: saving ? 'Menyimpan...' : 'Simpan perubahan',
                            icon: Icons.check_rounded,
                            onPressed: saving ? null : updateProfile,
                          ),
                        ],

                        const SizedBox(height: 18),

                        OutlinedButton.icon(
                          onPressed: loggingOut ? null : logout,
                          icon: const Icon(Icons.logout_rounded),
                          label: Text(loggingOut ? 'Logging out...' : 'Logout'),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: DutioPalette.of(context).surface,
                            foregroundColor: DutioPalette.of(context).accent,
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

  // Widget untuk menampilkan field akun
  Widget _field(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: DutioPalette.of(context).textStrong,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 5),
      TextField(
        controller: controller,
        readOnly: !editing || readOnly,
        decoration: InputDecoration(
          filled: true,
          fillColor: DutioPalette.of(context).surface,
          suffixIcon: editing && !readOnly
              ? Icon(Icons.edit_outlined, color: DutioPalette.of(context).sage)
              : null,
        ),
      ),
    ],
  );
}
