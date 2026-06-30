import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';

class AnimatedPlantLogo extends StatefulWidget {
  const AnimatedPlantLogo({super.key, this.size = 128});

  final double size;

  @override
  State<AnimatedPlantLogo> createState() => _AnimatedPlantLogoState();
}

class _AnimatedPlantLogoState extends State<AnimatedPlantLogo>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _entryController;
  late final Animation<double> _pulse;
  late final Animation<double> _entryScale;
  late final Animation<double> _entryFade;
  late final Animation<double> _glowPulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _pulse = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutCubic),
    );

    _entryScale = Tween<double>(begin: 0.72, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutBack),
    );

    _entryFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );

    _glowPulse = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _entryController]),
      builder: (context, _) {
        final glowOpacity = _glowPulse.value;

        return Transform.scale(
          scale: _pulse.value * _entryScale.value,
          child: Opacity(
            opacity: _entryFade.value,
            child: SizedBox(
              width: widget.size * 1.35,
              height: widget.size * 1.35,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer soft glow
                  Container(
                    width: widget.size * 1.2,
                    height: widget.size * 1.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.22 * glowOpacity),
                          blurRadius: 48,
                          spreadRadius: 8,
                        ),
                        BoxShadow(
                          color: const Color(0xFFA5D6A7).withValues(alpha: 0.35 * glowOpacity),
                          blurRadius: 64,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  // Mid glow ring
                  Container(
                    width: widget.size * 1.05,
                    height: widget.size * 1.05,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.18 * glowOpacity),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                  // Glass orb
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        width: widget.size,
                        height: widget.size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.28),
                              Colors.white.withValues(alpha: 0.10),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.42),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.10),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: CustomPaint(
                          painter: _PlantLogoPainter(
                            animation: _pulseController.value,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PlantLogoPainter extends CustomPainter {
  _PlantLogoPainter({required this.animation});

  final double animation;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final stemPaint = Paint()
      ..color = const Color(0xFF1B5E20)
      ..strokeWidth = 3.8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final leafPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF43A047), AppColors.primary],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final accentPaint = Paint()
      ..color = const Color(0xFFC8E6C9)
      ..style = PaintingStyle.fill;

    final sway = math.sin(animation * math.pi * 2) * 2.5;

    canvas.save();
    canvas.translate(center.dx, center.dy);

    final stemPath = Path()
      ..moveTo(0, 30)
      ..quadraticBezierTo(sway, 10, 0, -20);
    canvas.drawPath(stemPath, stemPaint);

    _drawLeaf(canvas, leafPaint, -15 + sway * 0.4, -2, -0.55);
    _drawLeaf(canvas, accentPaint, 15 - sway * 0.4, -12, 0.55);
    _drawLeaf(canvas, leafPaint, -11 + sway * 0.3, -24, -0.35);
    _drawLeaf(canvas, accentPaint, 11 - sway * 0.3, -30, 0.35);

    canvas.restore();
  }

  void _drawLeaf(
    Canvas canvas,
    Paint paint,
    double dx,
    double dy,
    double rotation,
  ) {
    canvas.save();
    canvas.translate(dx, dy);
    canvas.rotate(rotation);

    final leaf = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(13, -5, 20, -16)
      ..quadraticBezierTo(9, -11, 0, 0);

    canvas.drawPath(leaf, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PlantLogoPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
