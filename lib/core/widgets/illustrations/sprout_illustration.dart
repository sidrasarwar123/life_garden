import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';

class SproutIllustration extends StatelessWidget {
  const SproutIllustration({this.size = 100});
  final double size;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.plantBg,
      ),
      padding: EdgeInsets.all(size * 0.18),
      child: CustomPaint(painter: _SproutPainter()),
    );
  }
}

class _SproutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
 
    // Pot
    final potPaint = Paint()..color = AppColors.pot;
    final potPath = Path()
      ..moveTo(w * 0.28, h * 0.75)
      ..lineTo(w * 0.72, h * 0.75)
      ..lineTo(w * 0.62, h)
      ..lineTo(w * 0.38, h)
      ..close();
    canvas.drawPath(potPath, potPaint);
 
    // Soil
    final soilPaint = Paint()..color = AppColors.soil;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.26, h * 0.70, w * 0.48, h * 0.08),
        const Radius.circular(3),
      ),
      soilPaint,
    );
 
    // Stem
    final stemPaint = Paint()
      ..color = AppColors.stem
      ..strokeWidth = w * 0.045
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.5, h * 0.70),
      Offset(w * 0.5, h * 0.32),
      stemPaint,
    );
 
    // Left leaf
    final leafPaint = Paint()..color = AppColors.leaf;
    final leftLeaf = Path()
      ..moveTo(w * 0.5, h * 0.42)
      ..quadraticBezierTo(w * 0.10, h * 0.30, w * 0.22, h * 0.10)
      ..quadraticBezierTo(w * 0.45, h * 0.18, w * 0.5, h * 0.42)
      ..close();
    canvas.drawPath(leftLeaf, leafPaint);
 
    // Right leaf
    final rightLeafPaint = Paint()..color = AppColors.leafLight;
    final rightLeaf = Path()
      ..moveTo(w * 0.5, h * 0.40)
      ..quadraticBezierTo(w * 0.92, h * 0.26, w * 0.80, h * 0.06)
      ..quadraticBezierTo(w * 0.56, h * 0.14, w * 0.5, h * 0.40)
      ..close();
    canvas.drawPath(rightLeaf, rightLeafPaint);
  }
 
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}