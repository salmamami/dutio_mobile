
import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              size: const Size(100, 100),
              painter: DutioLogoPainter(),
            ),
            const SizedBox(height: 25),
            const Text(
              'D U T I O',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppTheme.dark,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DutioLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.darkGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    path.moveTo(centerX, 5);
    path.lineTo(size.width - 5, centerY);
    path.lineTo(centerX, size.height - 5);
    path.lineTo(5, centerY);
    path.close();

    canvas.drawPath(path, paint);

    final inner = Path();
    inner.moveTo(centerX, 5);
    inner.lineTo(centerX, centerY);
    inner.lineTo(5, centerY);

    inner.moveTo(size.width - 5, centerY);
    inner.lineTo(centerX, centerY);
    inner.lineTo(centerX, size.height - 5);

    inner.moveTo(centerX, 5);
    inner.lineTo(size.width - 5, centerY);
    inner.lineTo(centerX, centerY);

    inner.moveTo(5, centerY);
    inner.lineTo(centerX, size.height - 5);
    inner.lineTo(centerX, centerY);

    canvas.drawPath(inner, paint);

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: 18,
        height: 18,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
