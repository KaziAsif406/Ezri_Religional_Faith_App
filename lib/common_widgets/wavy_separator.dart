import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/colors.gen.dart';

class WavySeparator extends StatelessWidget {
  const WavySeparator({
    super.key,
    required this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 5.h,
      child: CustomPaint(
        painter: WavyLinePainter(color: color),
      ),
    );
  }
}

class WavyLinePainter extends CustomPainter {
  WavyLinePainter({required this.color});

  final Color? color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color ?? AppColors.cF5EDD7.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5.w;

    final Path path = Path();
    const double waves = 15;
    final double segment = size.width / waves;

    path.moveTo(0, size.height / 2);
    for (double i = 0; i < waves; i++) {
      final double startX = i * segment;
      final double endX = startX + segment;
      path.quadraticBezierTo(
        startX + segment / 2,
        i % 2 == 0 ? 0 : size.height,
        endX,
        size.height / 2,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}