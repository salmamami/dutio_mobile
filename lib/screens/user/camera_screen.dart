
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_theme.dart';
import '../../widgets/dutio_widgets.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _loading = false;

  Future<void> _takePicture() async {
    try {
      setState(() => _loading = true);

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (!mounted) return;
      setState(() => _loading = false);

      if (image == null) return;

      Navigator.pushReplacementNamed(
        context,
        '/user/photo-preview',
        arguments: image,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kamera tidak dapat dibuka: $e')),
      );
    }
  }

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
                Image.asset(
                  'assets/images/bathroom.jpg',
                  fit: BoxFit.cover,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.white,
                        width: 2,
                      ),
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
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 11,
                      ),
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
                onTap: _loading ? null : _takePicture,
                child: Container(
                  width: 68,
                  height: 68,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.white,
                      width: 4,
                    ),
                  ),
                  child: _loading
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            color: AppTheme.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const DecoratedBox(
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
