import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class PhotoPreviewScreen extends StatefulWidget {
  const PhotoPreviewScreen({super.key});

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  final TextEditingController _keteranganController = TextEditingController();

  XFile? _image;
  Future<Uint8List>? _imageBytes;
  bool _uploading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_image == null) {
      final argument = ModalRoute.of(context)?.settings.arguments;

      if (argument is XFile) {
        _image = argument;
        _imageBytes = argument.readAsBytes();
      }
    }
  }

  // Mengirim foto laporan ke API Laravel
  Future<void> _uploadReport() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih foto terlebih dahulu.')),
      );
      return;
    }

    setState(() => _uploading = true);

    try {
      // Mengambil token login
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('auth_token');

      if (token == null || token.isEmpty) {
        throw Exception('Sesi login tidak ditemukan. Silakan login ulang.');
      }

      // Membaca file foto
      final bytes = await _image!.readAsBytes();

      // Membuat request upload multipart
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/laporan'),
      );

      // Header autentikasi
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // Menambahkan foto
      request.files.add(
        http.MultipartFile.fromBytes('foto', bytes, filename: _image!.name),
      );

      // Menambahkan keterangan jika diisi
      final keterangan = _keteranganController.text.trim();

      if (keterangan.isNotEmpty) {
        request.fields['keterangan'] = keterangan;
      }

      // Mengirim request ke server
      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      // Membaca respons API
      Map<String, dynamic> responseData = {};

      try {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          responseData = decoded;
        }
      } catch (_) {
        // Respons server bukan JSON
      }

      // Jika upload berhasil
      if (response.statusCode == 201) {
        if (!mounted) return;

        Navigator.pushReplacementNamed(
          context,
          '/user/upload-success',
          arguments: responseData,
        );
      } else {
        // Jika upload gagal
        final message =
            responseData['message']?.toString() ??
            'Upload gagal. Kode: ${response.statusCode}';

        throw Exception(message);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _uploading = false);
      }
    }
  }

  @override
  void dispose() {
    _keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DutioHeader(
              title: 'Ambil Foto Laporan Piket',
              subtitle: 'Review foto sebelum dikirim',
              showBack: true,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Tampilan preview foto
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: _image == null
                            ? const Center(child: Text('Foto belum dipilih.'))
                            : FutureBuilder<Uint8List>(
                                future: _imageBytes,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (snapshot.hasError || !snapshot.hasData) {
                                    return const Center(
                                      child: Text('Foto gagal ditampilkan.'),
                                    );
                                  }

                                  return Image.memory(
                                    snapshot.data!,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  );
                                },
                              ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Keterangan laporan
                    TextField(
                      controller: _keteranganController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: 'Keterangan laporan (opsional)',
                        filled: true,
                        fillColor: DutioPalette.of(context).surfaceVariant,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tombol ulangi dan upload
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _uploading
                          ? null
                          : () => Navigator.pop(context),
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Ulangi'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: DutioPalette.of(context).accent,
                        side: BorderSide(
                          color: DutioPalette.of(context).accent,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _uploading ? null : _uploadReport,
                      icon: _uploading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                color: AppTheme.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.upload_rounded),
                      label: Text(_uploading ? 'Mengunggah...' : 'Upload'),
                      style: FilledButton.styleFrom(
                        backgroundColor: DutioPalette.of(context).action,
                        foregroundColor: AppTheme.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
