import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_theme.dart';

class UserPointsScreen extends StatefulWidget {
  const UserPointsScreen({super.key});

  @override
  State<UserPointsScreen> createState() => _UserPointsScreenState();
}

class _UserPointsScreenState extends State<UserPointsScreen> {
  bool evaluations = false;
  bool isLoading = true;

  int totalPoin = 0;

  String? errorMessage;

  List<Map<String, dynamic>> riwayat = [];

  @override
  void initState() {
    super.initState();
    fetchCrewPoints();
  }

  // Mengambil data Crew Points dari Laravel API
  Future<void> fetchCrewPoints() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        throw Exception('Token login tidak ditemukan. Silakan login kembali.');
      }

      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/crew-points'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        final data = responseData['data'];

        if (!mounted) return;

        setState(() {
          totalPoin = (data['total_poin'] as num?)?.toInt() ?? 0;

          riwayat = (data['riwayat'] as List? ?? [])
              .map((item) => Map<String, dynamic>.from(item))
              .toList();

          isLoading = false;
        });
      } else {
        throw Exception(
          responseData['message'] ?? 'Gagal mengambil data Crew Points.',
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(color: DutioPalette.of(context).sage),

              // Header Crew Points
              Positioned(
                top: 12,
                left: 20,
                right: 20,
                height: 180,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Crew Points',
                            style: TextStyle(
                              color: DutioPalette.of(context).onAccent,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Informasi poin',
                          onPressed: () => showDialog<void>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Tentang poin'),
                              content: const Text(
                                'Aktivitas piket yang valid akan tercatat sebagai poin.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Mengerti'),
                                ),
                              ],
                            ),
                          ),
                          icon: Icon(
                            Icons.info_outline_rounded,
                            color: DutioPalette.of(context).onAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: DutioPalette.of(context).surface,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .10),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isLoading ? '-' : totalPoin.toString(),
                                    style: TextStyle(
                                      color: DutioPalette.of(context)
                                          .textPrimary,
                                      fontSize: 40,
                                      height: 1,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Total Poin',
                                    style: TextStyle(
                                      color: DutioPalette.of(context)
                                          .secondaryText,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: DutioPalette.of(context)
                                      .surfaceVariant,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.verified_rounded,
                                      color: DutioPalette.of(context).accent,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Piket terakhir',
                                            style: TextStyle(
                                              color: DutioPalette.of(context)
                                                  .textPrimary,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            'Lihat riwayat penilaian',
                                            style: TextStyle(
                                              color: DutioPalette.of(context)
                                                  .secondaryText,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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

              // Ilustrasi Crew Points
              Positioned(
                left: 28,
                top: 72,
                child: IgnorePointer(
                  child: Icon(
                    Icons.assignment_turned_in_rounded,
                    size: 96,
                    color: const Color(0xFFFFD18B).withValues(alpha: .35),
                  ),
                ),
              ),

              // Panel Poin dan Evaluasi
              Positioned.fill(
                top: 208,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(14, 26, 14, 14),
                  decoration: BoxDecoration(
                    color: DutioPalette.of(context).background,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _tab(
                            'Poin',
                            !evaluations,
                            () => setState(() => evaluations = false),
                          ),
                          const SizedBox(width: 8),
                          _tab(
                            'Evaluasi Piket',
                            evaluations,
                            () => setState(() => evaluations = true),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: DutioPalette.of(context).mutedSurface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: _buildContent(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Menampilkan isi tab berdasarkan data API
  Widget _buildContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 40),
            const SizedBox(height: 10),
            Text(errorMessage!, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: fetchCrewPoints,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    // Tab Evaluasi Piket
    if (evaluations) {
      final dataEvaluasi = riwayat.where((item) {
        final evaluasi = item['evaluasi'];

        return evaluasi != null && evaluasi.toString().trim().isNotEmpty;
      }).toList();

      if (dataEvaluasi.isEmpty) {
        return _emptyMessage('Belum ada evaluasi piket.');
      }

      return RefreshIndicator(
        onRefresh: fetchCrewPoints,
        child: ListView(
          children: dataEvaluasi.map((item) {
            final poin = (item['poin'] as num?)?.toInt() ?? 0;

            return _pointRow(
              poin > 0 ? '+$poin' : poin.toString(),
              item['evaluasi'].toString(),
              poin >= 0 ? const Color(0xFF98C888) : const Color(0xFFDC9789),
            );
          }).toList(),
        ),
      );
    }

    // Tab Riwayat Poin
    if (riwayat.isEmpty) {
      return _emptyMessage('Belum ada riwayat poin.');
    }

    return RefreshIndicator(
      onRefresh: fetchCrewPoints,
      child: ListView(
        children: riwayat.map((item) {
          final poin = (item['poin'] as num?)?.toInt() ?? 0;

          final evaluasi = item['evaluasi']?.toString();

          final detail = evaluasi != null && evaluasi.isNotEmpty
              ? evaluasi
              : 'Penilaian piket';

          return _pointRow(
            poin > 0 ? '+$poin' : poin.toString(),
            detail,
            poin >= 0 ? const Color(0xFF98C888) : const Color(0xFFDC9789),
          );
        }).toList(),
      ),
    );
  }

  // Tampilan ketika data masih kosong
  Widget _emptyMessage(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 42,
            color: DutioPalette.of(context).secondaryText,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: DutioPalette.of(context).secondaryText,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // Tab navigasi Poin dan Evaluasi Piket
  Widget _tab(String label, bool active, VoidCallback onTap) => Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active
              ? DutioPalette.of(context).mutedSurface
              : DutioPalette.of(context).pointsInactiveSurface,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: active
                ? DutioPalette.of(context).onMutedSurface
                : DutioPalette.of(context).secondaryText,
          ),
        ),
      ),
    ),
  );

  // Tampilan setiap riwayat poin
  Widget _pointRow(String point, String detail, Color badge) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: DutioPalette.of(context).surface,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          decoration: BoxDecoration(
            color: badge,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            point,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(detail, style: const TextStyle(fontSize: 13))),
      ],
    ),
  );
}
