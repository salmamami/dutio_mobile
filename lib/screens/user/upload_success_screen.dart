import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class UploadSuccessScreen extends StatelessWidget {
  const UploadSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final data = arguments is Map ? arguments : {};

    final status = data['status']?.toString() ?? 'Menunggu';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 148,
                height: 148,
                decoration: BoxDecoration(
                  color: DutioPalette.of(context).surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: DutioPalette.of(context).accent,
                  size: 96,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Upload Complete',
                style: TextStyle(
                  color: DutioPalette.of(context).accent,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Foto laporan berhasil dikirim. Laporanmu sedang menunggu verifikasi koordinator.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: DutioPalette.of(context).textPrimary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              DutioPanel(
                child: Row(
                  children: [
                    const Icon(
                      Icons.hourglass_top_rounded,
                      color: Color(0xFFD6A94A),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Status laporan\n$status',
                        style: TextStyle(
                          color: DutioPalette.of(context).accent,
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
}
