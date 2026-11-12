
import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class PhotoPreviewScreen extends StatelessWidget {
  const PhotoPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 19,
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ambil Foto Laporan Piket',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppTheme.darkGreen,
                          ),
                        ),
                        Text(
                          'Review foto sebelum dikirim',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.eco_outlined,
                    color: AppTheme.darkGreen,
                    size: 25,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),

            // PHOTO PREVIEW
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFFAAA99D),
                    child: CustomPaint(
                      painter: _BathroomPainter(),
                      child: const Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: Colors.white54,
                          size: 45,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ACTION BUTTONS
            Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Ulangi'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.darkGreen,
                        side: const BorderSide(
                          color: AppTheme.darkGreen,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/upload-success',
                        );
                      },
                      icon: const Icon(Icons.upload_rounded),
                      label: const Text('Upload'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.darkGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
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

class _BathroomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final wall = Paint()..color = const Color(0xFFB7B6AA);
    final floor = Paint()..color = const Color(0xFF55554E);
    final tile = Paint()
      ..color = Colors.white30
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.65),
      wall,
    );

    canvas.drawRect(
      Rect.fromLTWH(
        0,
        size.height * 0.65,
        size.width,
        size.height * 0.35,
      ),
      floor,
    );

    for (double y = 0; y < size.height * 0.65; y += 65) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        tile,
      );
    }

    for (double x = 0; x < size.width; x += 75) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height * 0.65),
        tile,
      );
    }

    canvas.drawLine(
      Offset(0, size.height * 0.65),
      Offset(size.width, size.height * 0.65),
      tile,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
