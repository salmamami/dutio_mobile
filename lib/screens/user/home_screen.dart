import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({
    super.key,
    required this.onMission,
    required this.hasUnreadNotifications,
    required this.onNotifications,
  });

  final VoidCallback onMission;
  final bool hasUnreadNotifications;
  final VoidCallback onNotifications;

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  static const String baseUrl = 'http://192.168.2.184:8000/api';

  bool isLoading = true;
  String? errorMessage;
  Map<String, dynamic>? jadwal;

  @override
  void initState() {
    super.initState();
    loadJadwal();
  }

  // Mengambil data jadwal dari Laravel API
  Future<void> loadJadwal() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      // Mengambil token hasil login
      final token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        throw Exception(
          'Token login tidak ditemukan. Silakan login kembali.',
        );
      }

      // Mengirim request ke API jadwal
      final response = await http.get(
        Uri.parse('$baseUrl/jadwal'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        if (result['success'] == true) {
          final List<dynamic> data = result['data'];

          if (data.isNotEmpty) {
            jadwal = Map<String, dynamic>.from(data.first);
          } else {
            jadwal = null;
          }
        } else {
          throw Exception(
            result['message'] ?? 'Data jadwal gagal dimuat.',
          );
        }
      } else if (response.statusCode == 401) {
        throw Exception(
          'Sesi login berakhir. Silakan login kembali.',
        );
      } else {
        throw Exception(
          'Gagal mengambil jadwal. Kode: ${response.statusCode}',
        );
      }
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    }

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  // Mengubah format tanggal menjadi tanggal Indonesia
  String formatTanggal(String? tanggal) {
    if (tanggal == null || tanggal.isEmpty) {
      return '-';
    }

    try {
      final date = DateTime.parse(tanggal);

      const bulan = [
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember',
      ];

      return '${date.day} ${bulan[date.month - 1]} ${date.year}';
    } catch (_) {
      return tanggal;
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
            child: Row(
              children: [
                const DutioLogo(size: 38),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        jadwal?['kamar'] ?? 'Anggota DUTIO',
                        style: TextStyle(
                          color: DutioPalette.of(context).accent,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                _roundIcon(
                  context,
                  Icons.notifications_none_rounded,
                  widget.onNotifications,
                  showBadge: widget.hasUnreadNotifications,
                ),
                const SizedBox(width: 10),
                _roundIcon(
                  context,
                  Icons.person_outline_rounded,
                  () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 36),
              children: [
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    color: DutioPalette.of(context).homeHeroBlush,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 18,
                        right: 126,
                        top: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Crew',
                              style: TextStyle(
                                color: DutioPalette.of(context).background,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                height: .95,
                              ),
                            ),
                            Text(
                              'on Duty',
                              style: TextStyle(
                                color: DutioPalette.of(context).accent,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                height: 1.05,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              'Cek detail piket kamu 🌱',
                              style: TextStyle(
                                color: DutioPalette.of(context)
                                    .textPrimary
                                    .withValues(alpha: .8),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 4,
                        bottom: 0,
                        width: 130,
                        height: 155,
                        child: Image.asset(
                          'assets/images/mbak.png',
                          key: const ValueKey('crew-duty-image'),
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Kartu informasi jadwal dari API
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: DutioPalette.of(context).sage,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 160,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : errorMessage != null
                          ? SizedBox(
                              height: 160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.wifi_off_rounded,
                                    color: AppTheme.white,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    errorMessage!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: AppTheme.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: loadJadwal,
                                    child: const Text(
                                      'Coba Lagi',
                                      style: TextStyle(
                                        color: AppTheme.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : jadwal == null
                              ? const SizedBox(
                                  height: 160,
                                  child: Center(
                                    child: Text(
                                      'Belum ada jadwal piket.',
                                      style: TextStyle(
                                        color: AppTheme.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      jadwal?['kamar'] ?? '-',
                                      style: TextStyle(
                                        color: DutioPalette.of(context)
                                            .onAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      jadwal?['area'] ?? '-',
                                      style: const TextStyle(
                                        color: AppTheme.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    _roomInfo(
                                      context,
                                      Icons.calendar_month_rounded,
                                      '${jadwal?['hari'] ?? '-'}, '
                                      '${formatTanggal(jadwal?['tanggal'])}',
                                    ),
                                    const SizedBox(height: 8),
                                    _roomInfo(
                                      context,
                                      Icons.fact_check_rounded,
                                      jadwal?['status'] ?? '-',
                                    ),
                                    if (jadwal?['keterangan_tanggal'] !=
                                        null) ...[
                                      const SizedBox(height: 8),
                                      _roomInfo(
                                        context,
                                        Icons.today_rounded,
                                        jadwal?['keterangan_tanggal'],
                                      ),
                                    ],
                                  ],
                                ),
                ),
                const SizedBox(height: 16),
                _homeAction(
                  context,
                  title: 'Ketuk untuk melihat tugas piket area',
                  label: 'To Do Checklist',
                  icon: Icons.fact_check_rounded,
                  onTap: widget.onMission,
                ),
                const SizedBox(height: 14),
                _homeAction(
                  context,
                  title: 'Ketuk untuk mengunggah foto laporan',
                  label: 'Laporan',
                  icon: Icons.cloud_upload_rounded,
                  onTap: () {
                    Navigator.pushNamed(context, '/user/report');
                  },
                ),
              ],
            ),
          ),
        ],
      );

  // Tombol ikon dengan indikator notifikasi
  static Widget _roundIcon(
    BuildContext context,
    IconData icon,
    VoidCallback onTap, {
    bool showBadge = false,
  }) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor:
                  DutioPalette.of(context).neutralSurface,
              child: Icon(
                icon,
                color: DutioPalette.of(context).textStrong,
                size: 25,
              ),
            ),
            if (showBadge)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  key: const ValueKey('unread-notification-badge'),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: DutioPalette.of(context).neutralSurface,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );

  // Informasi detail jadwal
  static Widget _roomInfo(
    BuildContext context,
    IconData icon,
    String label,
  ) =>
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: DutioPalette.of(context).surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: DutioPalette.of(context).textStrong,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: DutioPalette.of(context).textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );

  // Tombol navigasi pada halaman Home
  static Widget _homeAction(
    BuildContext context, {
    required String title,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: DutioPalette.of(context).surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: DutioPalette.of(context).border,
          ),
          boxShadow: [
            BoxShadow(
              color: DutioPalette.of(context).blush,
              offset: const Offset(0, 5),
              blurRadius: 0,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: DutioPalette.of(context).accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      icon,
                      color: DutioPalette.of(context).textStrong,
                      size: 36,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                          color: DutioPalette.of(context).softSurface,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: DutioPalette.of(context).textStrong,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
