import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class ReportUploadScreen extends StatefulWidget {
  const ReportUploadScreen({super.key});

  @override
  State<ReportUploadScreen> createState() => _ReportUploadScreenState();
}

class _ReportUploadScreenState extends State<ReportUploadScreen> {
  final ImagePicker _picker = ImagePicker();

  bool _loading = false;
  int? selected;

  Future<void> _pickGalleryImage() async {
    try {
      setState(() => _loading = true);

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (!mounted) return;

      setState(() => _loading = false);

      if (image == null) return;

      Navigator.pushNamed(context, '/user/photo-preview', arguments: image);
    } catch (e) {
      if (!mounted) return;

      setState(() => _loading = false);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal memilih foto: $e')));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const DutioHeader(title: 'Unggah Foto Laporan Piket', showBack: true),
          const SizedBox(height: 12),

          // Area untuk memilih foto dari galeri
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: _loading ? null : _pickGalleryImage,
              child: Container(
                key: const ValueKey('report-upload-dropzone'),
                height: 120,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: DutioPalette.of(context).sage,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      color: DutioPalette.of(context).background,
                      size: 32,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Unggah Foto',
                      style: TextStyle(
                        color: DutioPalette.of(context).onAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Silakan pilih gambar dari galeri Anda',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppTheme.white, fontSize: 11),
                    ),
                    if (_loading)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Judul foto terbaru
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Foto Terbaru Anda',
                style: TextStyle(
                  color: DutioPalette.of(context).secondaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          // Daftar foto terbaru
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: .95,
              ),
              itemBuilder: (context, index) {
                final colors = [
                  DutioPalette.of(context).sage,
                  const Color(0xFFD8BCA2),
                  const Color(0xFFB5A884),
                  const Color(0xFFB7B6AD),
                  const Color(0xFFC9D2BC),
                  const Color(0xFF9EAA8D),
                ];

                return InkWell(
                  key: ValueKey('recent-photo-$index'),
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    setState(() => selected = index);
                  },
                  child: Container(
                    key: ValueKey('photo-tile-$index'),
                    decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selected == index
                            ? DutioPalette.of(context).action
                            : Colors.transparent,
                        width: 4,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (index == 0)
                          Image.asset(
                            'assets/images/bathroom.jpg',
                            fit: BoxFit.cover,
                          )
                        else
                          Icon(
                            index.isEven
                                ? Icons.image_outlined
                                : Icons.photo_outlined,
                            color: AppTheme.white.withValues(alpha: .8),
                            size: 36,
                          ),

                        if (selected == index)
                          Positioned(
                            top: 5,
                            right: 5,
                            child: CircleAvatar(
                              key: const ValueKey('selected-photo-indicator'),
                              radius: 14,
                              backgroundColor: DutioPalette.of(context).action,
                              child: Icon(
                                Icons.check_rounded,
                                color: AppTheme.white,
                                size: 18,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Tombol memilih foto dari galeri
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
            child: DutioPrimaryButton(
              label: 'Pilih Foto dari Galeri',
              onPressed: _loading ? null : _pickGalleryImage,
            ),
          ),
        ],
      ),
    ),
  );
}
