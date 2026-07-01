import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';

class WateringCanIllustration extends StatelessWidget {
  const WateringCanIllustration({this.size = 120});
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
      padding: EdgeInsets.all(size * 0.14),
      child: CustomPaint(painter: _WateringCanPainter()),
    );
  }
}
 
class _WateringCanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
 
    // --- Small sprout on the ground, bottom-left ---
    final stemPaint = Paint()
      ..color = AppColors.stem
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.22, h * 0.92),
      Offset(w * 0.22, h * 0.68),
      stemPaint,
    );
 
    final leafPaint = Paint()..color = AppColors.leaf;
    final leaf = Path()
      ..moveTo(w * 0.22, h * 0.74)
      ..quadraticBezierTo(w * 0.02, h * 0.64, w * 0.08, h * 0.50)
      ..quadraticBezierTo(w * 0.26, h * 0.56, w * 0.22, h * 0.74)
      ..close();
    canvas.drawPath(leaf, leafPaint);
 
    final leaf2Paint = Paint()..color = AppColors.leafLight;
    final leaf2 = Path()
      ..moveTo(w * 0.22, h * 0.72)
      ..quadraticBezierTo(w * 0.40, h * 0.62, w * 0.36, h * 0.48)
      ..quadraticBezierTo(w * 0.20, h * 0.54, w * 0.22, h * 0.72)
      ..close();
    canvas.drawPath(leaf2, leaf2Paint);
 
    // ground
    final soilPaint = Paint()..color = AppColors.soil;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.04, h * 0.90, w * 0.40, h * 0.06),
        const Radius.circular(3),
      ),
      soilPaint,
    );
 
    // --- Watering can, top-right, tilted ---
    canvas.save();
    canvas.translate(w * 0.66, h * 0.30);
    canvas.rotate(-0.35);
 
    final canPaint = Paint()..color = AppColors.primaryDark;
    final canBody = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: w * 0.42, height: h * 0.26),
      const Radius.circular(10),
    );
    canvas.drawRRect(canBody, canPaint);
 
    // handle
    final handlePaint = Paint()
      ..color = AppColors.primaryDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(0, -h * 0.16), width: w * 0.26, height: h * 0.20),
      3.4,
      2.7,
      false,
      handlePaint,
    );
 
    // spout
    final spoutPaint = Paint()..color = AppColors.primaryDark;
    final spout = Path()
      ..moveTo(w * 0.20, -h * 0.04)
      ..lineTo(w * 0.40, -h * 0.14)
      ..lineTo(w * 0.42, -h * 0.08)
      ..lineTo(w * 0.22, h * 0.02)
      ..close();
    canvas.drawPath(spout, spoutPaint);
 
    canvas.restore();
 
    // --- Water droplets falling from spout toward sprout ---
    final dropPaint = Paint()..color = AppColors.primaryLight.withValues(alpha: 0.85);
    final dropCenters = [
      Offset(w * 0.50, h * 0.46),
      Offset(w * 0.42, h * 0.56),
      Offset(w * 0.34, h * 0.64),
    ];
    for (final c in dropCenters) {
      final drop = Path()
        ..moveTo(c.dx, c.dy - 5)
        ..quadraticBezierTo(c.dx + 5, c.dy + 4, c.dx, c.dy + 8)
        ..quadraticBezierTo(c.dx - 5, c.dy + 4, c.dx, c.dy - 5)
        ..close();
      canvas.drawPath(drop, dropPaint);
    }
  }
 
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}