import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
      child: Column(
        children: [
          const DutioHeader(
            title: 'Ambil Foto Laporan Piket',
            subtitle: 'Pastikan kondisi area terlihat jelas',
            showBack: true,
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/bathroom.jpg', fit: BoxFit.cover),
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.white, width: 2),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '●  Camera Preview',
                      style: TextStyle(color: AppTheme.white, fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 120,
            width: double.infinity,
            color: Colors.black,
            child: Center(
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () =>
                    Navigator.pushNamed(context, '/user/photo-preview'),
                child: Container(
                  width: 68,
                  height: 68,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.white, width: 4),
                  ),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
