
import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              color: const Color(0xFFFFF9E8),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 13,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 19,
                      color: Colors.black,
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ambil Foto Laporan Piket',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF176B3A),
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Pastikan kondisi area terlihat jelas',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // CAMERA PREVIEW
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF77766D),
                          Color(0xFF34342F),
                          Color(0xFF171714),
                        ],
                      ),
                    ),
                    child: CustomPaint(
                      painter: CameraPreviewPainter(),
                    ),
                  ),

                  // CAMERA GUIDE
                  Center(
                    child: Container(
                      width: 250,
                      height: 330,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white54,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  // CAMERA INFO
                  Positioned(
                    top: 15,
                    left: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 8,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Camera Preview',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // CAMERA CONTROLS
            Container(
              height: 125,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 45),

                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur kamera akan diaktifkan nanti'),
                        ),
                      );
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.flip_camera_ios_outlined,
                      color: Colors.white,
                      size: 28,
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

// CAMERA PREVIEW ILLUSTRATION
class CameraPreviewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final wallPaint = Paint()..color = const Color(0xFFAAA99D);
    final floorPaint = Paint()..color = const Color(0xFF45453E);
    final tilePaint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.68),
      wallPaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(
        0,
        size.height * 0.68,
        size.width,
        size.height * 0.32,
      ),
      floorPaint,
    );

    // Wall tiles
    for (double y = 0; y < size.height * 0.68; y += 65) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        tilePaint,
      );
    }

    for (double x = 0; x < size.width; x += 75) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height * 0.68),
        tilePaint,
      );
    }

    // Floor tiles
    for (double y = size.height * 0.68;
        y < size.height;
        y += 55) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        tilePaint,
      );
    }

    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.68),
      Offset(size.width * 0.5, size.height),
      tilePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
