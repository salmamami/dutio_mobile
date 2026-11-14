import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class ReportUploadScreen extends StatefulWidget {
  const ReportUploadScreen({super.key});

  @override
  State<ReportUploadScreen> createState() => _ReportUploadScreenState();
}

class _ReportUploadScreenState extends State<ReportUploadScreen> {
  int? selected;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const DutioHeader(title: 'Unggah Foto Laporan Piket', showBack: true),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () => Navigator.pushNamed(context, '/user/camera'),
              child: Container(
                height: 145,
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
                      size: 40,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Unggah Foto',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Silakan pilih gambar dari galeri Anda',
                      style: TextStyle(color: AppTheme.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Recent Files',
                style: TextStyle(
                  color: DutioPalette.of(context).secondaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
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
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => setState(() => selected = index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selected == index
                            ? DutioPalette.of(context).accent
                            : Colors.transparent,
                        width: 3,
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
                              radius: 12,
                              backgroundColor: DutioPalette.of(context).action,
                              child: Icon(
                                Icons.check,
                                color: AppTheme.white,
                                size: 15,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
            child: DutioPrimaryButton(
              label: 'Unggah Foto',
              onPressed: selected == null
                  ? null
                  : () => Navigator.pushNamed(context, '/user/photo-preview'),
            ),
          ),
        ],
      ),
    ),
  );
}
