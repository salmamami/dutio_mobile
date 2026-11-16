import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class UserMissionScreen extends StatefulWidget {
  const UserMissionScreen({super.key});

  @override
  State<UserMissionScreen> createState() => _UserMissionScreenState();
}

class _UserMissionScreenState extends State<UserMissionScreen> {
  static const String baseUrl = 'http://172.16.18.115:8000/api';

  List<Map<String, dynamic>> tasks = [];

  String area = '-';
  String statusJadwal = '';
  int total = 0;
  int selesai = 0;
  int persen = 0;

  bool isLoading = true;
  String? errorMessage;
  bool showCompleted = false;

  final Set<int> updatingTasks = {};

  @override
  void initState() {
    super.initState();
    loadChecklist();
  }

  // Mengambil data checklist dari Laravel API
  Future<void> loadChecklist() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Token login tidak ditemukan. Silakan login kembali.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/checklist'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        final data = result['data'];

        if (!mounted) return;

        setState(() {
          area = data['area']?.toString() ?? '-';
          statusJadwal = data['status']?.toString() ?? '';

          tasks = (data['checklists'] as List)
              .map((item) => Map<String, dynamic>.from(item))
              .toList();

          total = data['total'] ?? 0;
          selesai = data['selesai'] ?? 0;
          persen = data['persen'] ?? 0;
          isLoading = false;
        });
      } else {
        throw Exception(result['message'] ?? 'Gagal mengambil data checklist.');
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  // Mengubah status checklist melalui Laravel API
  Future<void> toggleChecklist(int id, bool value) async {
    if (updatingTasks.contains(id)) return;

    final index = tasks.indexWhere((item) => item['id'] == id);

    if (index == -1) return;

    final oldValue = tasks[index]['selesai'] == true;

    setState(() {
      tasks[index]['selesai'] = value;
      updatingTasks.add(id);

      selesai = tasks.where((item) => item['selesai'] == true).length;
      persen = total > 0 ? ((selesai / total) * 100).round() : 0;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Token login tidak ditemukan.');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/checklist/$id/toggle'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'selesai': value}),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode != 200 || result['success'] != true) {
        throw Exception(result['message'] ?? 'Checklist gagal diperbarui.');
      }

      final data = result['data'];

      if (!mounted) return;

      setState(() {
        selesai = data['selesai_total'] ?? selesai;
        total = data['total'] ?? total;
        persen = data['persen'] ?? persen;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        tasks[index]['selesai'] = oldValue;

        selesai = tasks.where((item) => item['selesai'] == true).length;
        persen = total > 0 ? ((selesai / total) * 100).round() : 0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui checklist: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          updatingTasks.remove(id);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Memisahkan checklist yang selesai dan belum selesai
    final visible = tasks
        .where(
          (task) =>
              showCompleted ? task['selesai'] == true : task['selesai'] != true,
        )
        .toList();

    return Container(
      color: DutioPalette.of(context).sage,
      child: Column(
        children: [
          SizedBox(
            height: 322,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 190,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6E6C6),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                        right: 22,
                        top: 24,
                        child: DutioMissionLogo(),
                      ),
                      Center(
                        child: Text(
                          'Mission Cleanliness',
                          style: TextStyle(
                            color: DutioPalette.of(context).textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18,
                        top: 20,
                        child: IconButton(
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 142,
                  left: 18,
                  right: 18,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: DutioPalette.of(context).blush
                          .withValues(alpha: .95),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Progress',
                          style: TextStyle(
                            color: DutioPalette.of(context).onAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _statCard(
                              area,
                              'Area Piket',
                              Icons.cleaning_services_rounded,
                            ),
                            _statCard(
                              '$persen%',
                              'Progress',
                              Icons.timer_rounded,
                            ),
                            _statCard(
                              '$selesai/$total',
                              'task completed',
                              Icons.assignment_turned_in_rounded,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Centang tugas yang sudah selesai untuk memperbarui progres.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: DutioPalette.of(context).textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              key: const ValueKey('mission-lower-panel'),
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              decoration: BoxDecoration(
                color: DutioPalette.of(context).surfaceVariant,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Daftar Tugas',
                      style: TextStyle(
                        color: DutioPalette.of(context).textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _tab(
                        'Task List',
                        !showCompleted,
                        () => setState(() => showCompleted = false),
                      ),
                      const SizedBox(width: 8),
                      _tab(
                        'Completed Task',
                        showCompleted,
                        () => setState(() => showCompleted = true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      key: const ValueKey('mission-task-panel'),
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: DutioPalette.of(context).background,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: _buildTaskContent(visible),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tampilan daftar checklist
  Widget _buildTaskContent(List<Map<String, dynamic>> visible) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 40),
            const SizedBox(height: 8),
            Text(errorMessage!, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loadChecklist,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.event_busy_rounded, size: 40),
            const SizedBox(height: 8),
            const Text(
              'Tidak ada jadwal piket aktif.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loadChecklist,
              child: const Text('Muat Ulang'),
            ),
          ],
        ),
      );
    }

    if (visible.isEmpty) {
      return Center(
        child: Text(
          showCompleted
              ? 'Belum ada task yang selesai.'
              : 'Semua task sudah selesai!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: DutioPalette.of(context).secondaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadChecklist,
      child: ListView(
        children: [
          for (final task in visible)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: DutioPalette.of(context).surface,
                borderRadius: BorderRadius.circular(20),
                child: CheckboxListTile(
                  value: task['selesai'] == true,
                  activeColor: DutioPalette.of(context).accent,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  title: Text(
                    task['nama']?.toString() ?? '-',
                    style: TextStyle(
                      color: DutioPalette.of(context).textStrong,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  secondary: updatingTasks.contains(task['id'])
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : null,
                  onChanged: updatingTasks.contains(task['id'])
                      ? null
                      : (value) {
                          if (value != null) {
                            toggleChecklist(task['id'] as int, value);
                          }
                        },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String subtitle, IconData icon) => Expanded(
    child: Container(
      height: 76,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: DutioPalette.of(context).surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 19, color: DutioPalette.of(context).accent),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 9),
          ),
        ],
      ),
    ),
  );

  Widget _tab(String label, bool active, VoidCallback onTap) => Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: active
              ? DutioPalette.of(context).mutedSurface
              : DutioPalette.of(context).background,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: active
                ? DutioPalette.of(context).onMutedSurface
                : DutioPalette.of(context).secondaryText,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

class DutioMissionLogo extends StatelessWidget {
  const DutioMissionLogo({super.key});

  @override
  Widget build(BuildContext context) => const DutioLogo(size: 50);
}
