import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class UploadSuccessScreen extends StatelessWidget {
  const UploadSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 148,
              height: 148,
              decoration: const BoxDecoration(
                color: AppTheme.lightGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppTheme.darkGreen,
                size: 96,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Upload Complete',
              style: TextStyle(
                color: AppTheme.darkGreen,
                fontSize: 23,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'All selected photos have been successfully uploaded. Laporanmu menunggu verifikasi koordinator.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.dark, height: 1.5),
            ),
            const SizedBox(height: 24),
            const DutioPanel(
              child: Row(
                children: [
                  Icon(Icons.hourglass_top_rounded, color: Color(0xFFD6A94A)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Status laporan\nMenunggu Verifikasi',
                      style: TextStyle(
                        color: AppTheme.darkGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            DutioPrimaryButton(
              label: 'Kembali ke Home',
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/user',
                (route) => false,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
