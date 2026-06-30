import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';

class PlantGrowthWidget extends StatelessWidget {

    const PlantGrowthWidget({super.key});
  
    @override
    Widget build(BuildContext context) {
      return _buildPlantGrowth();
    }
  
   Widget _buildPlantGrowth() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.plantBg,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative plants background right side
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(AppSpacing.cardRadius),
                bottomRight: Radius.circular(AppSpacing.cardRadius),
              ),
              child: Container(
                width: 160,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x00E8F5E9), Color(0xFFB2DFDB)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              child: const _PlantIllustration(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                // Left content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Plant Growth',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text('🌿', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Keep completing tasks\nto grow your plant',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.15),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.buttonRadius),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text('🌱', style: TextStyle(fontSize: 12)),
                                SizedBox(width: 4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Stage 2',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryDark,
                                      ),
                                    ),
                                    Text(
                                      'Young Plant',
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Circular progress
                const SizedBox(width: AppSpacing.md),
                const _CircularGrowthIndicator(percent: 0.40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Circular Progress Indicator ───────────────────────────────────────────
class _CircularGrowthIndicator extends StatelessWidget {
  final double percent;
 
  const _CircularGrowthIndicator({required this.percent});
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: CustomPaint(
        painter: _ArcPainter(percent: percent),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(percent * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(
                'Growth',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _ArcPainter extends CustomPainter {
  final double percent;
 
  const _ArcPainter({required this.percent});
 
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
 
    // Background arc
    final bgPaint = Paint()
      ..color = AppColors.xpBarBg
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
 
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi * 0.75,
      math.pi * 1.5,
      false,
      bgPaint,
    );
 
    // Progress arc
    final progressPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
 
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi * 0.75,
      math.pi * 1.5 * percent,
      false,
      progressPaint,
    );
  }
 
  @override
  bool shouldRepaint(_ArcPainter old) => old.percent != percent;
}






// ── Plant Illustration ────────────────────────────────────────────────────
class _PlantIllustration extends StatelessWidget {
  const _PlantIllustration();
 
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PlantPainter(),
    );
  }
}
 
class _PlantPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
 
    // Sky/cloud background
    paint.color = const Color(0xFFE0F7FA);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height * 0.65),
        const Radius.circular(12),
      ),
      paint,
    );
 
    // Ground
    paint.color = const Color(0xFF8D6E63);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.1, size.height * 0.62,
            size.width * 0.8, size.height * 0.15),
        const Radius.circular(8),
      ),
      paint,
    );
 
    // Pot
    final potPaint = Paint()
      ..color = const Color(0xFFBF8C60)
      ..style = PaintingStyle.fill;
 
    final potPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.65)
      ..lineTo(size.width * 0.2, size.height * 0.85)
      ..lineTo(size.width * 0.8, size.height * 0.85)
      ..lineTo(size.width * 0.75, size.height * 0.65)
      ..close();
    canvas.drawPath(potPath, potPaint);
 
    // Pot rim
    potPaint.color = const Color(0xFFD4956A);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.2, size.height * 0.63,
            size.width * 0.6, size.height * 0.06),
        const Radius.circular(4),
      ),
      potPaint,
    );
 
    // Stem
    paint.color = const Color(0xFF388E3C);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.47, size.height * 0.15,
            size.width * 0.06, size.height * 0.5),
        const Radius.circular(3),
      ),
      paint,
    );
 
    // Main leaf
    _drawLeaf(canvas, size, size.width * 0.5, size.height * 0.2,
        size.width * 0.38, -0.4, const Color(0xFF4CAF50));
 
    // Left leaf
    _drawLeaf(canvas, size, size.width * 0.5, size.height * 0.32,
        size.width * 0.28, -0.7, const Color(0xFF66BB6A));
 
    // Right leaf
    _drawLeaf(canvas, size, size.width * 0.5, size.height * 0.28,
        size.width * 0.28, 0.7, const Color(0xFF81C784));
 
    // Small top leaf
    _drawLeaf(canvas, size, size.width * 0.5, size.height * 0.12,
        size.width * 0.24, 0.3, const Color(0xFF2E7D32));
  }
 
  void _drawLeaf(Canvas canvas, Size size, double x, double y,
      double leafSize, double angle, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
 
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(angle);
 
    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(-leafSize * 0.5, -leafSize * 0.5, 0, -leafSize)
      ..quadraticBezierTo(leafSize * 0.5, -leafSize * 0.5, 0, 0);
 
    canvas.drawPath(path, paint);
    canvas.restore();
  }
 
  @override
  bool shouldRepaint(_PlantPainter old) => false;
}
 

