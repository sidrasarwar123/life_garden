import 'dart:math';

import 'package:flutter/material.dart';
import 'package:life_garden/core/model/plant_model.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/theme/app_textstyle.dart';

// ─────────────────────────────────────────
// Falling Leaf data model (private)
// ─────────────────────────────────────────
class _FallingLeaf {
  double x;     // 0..1 of widget width
  double y;     // 0..1 of widget height (starts above screen)
  double speed; // fall speed per tick
  double angle; // current rotation
  double spin;  // rotation per tick
  double scale; // size multiplier
  double drift; // horizontal oscillation amplitude
  double phase; // oscillation phase offset
  Color color;

  _FallingLeaf({
    required this.x,
    required this.y,
    required this.speed,
    required this.angle,
    required this.spin,
    required this.scale,
    required this.drift,
    required this.phase,
    required this.color,
  });
}

// ─────────────────────────────────────────
// PlantHeroSection
// ─────────────────────────────────────────
class PlantHeroSection extends StatefulWidget {
  final PlantModel plant;
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const PlantHeroSection({
    super.key,
    required this.plant,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  State<PlantHeroSection> createState() => _PlantHeroSectionState();
}

class _PlantHeroSectionState extends State<PlantHeroSection>
    with TickerProviderStateMixin {
  // Sway animation
  late AnimationController _swayCtrl;
  late Animation<double> _swayAnim;

  // Falling-leaf ticker
  late AnimationController _leafCtrl;

  final List<_FallingLeaf> _leaves = [];
  final Random _rng = Random();
  double _tick = 0;

  static const _leafColors = [
    Color(0xFF66BB6A),
    Color(0xFF81C784),
    Color(0xFFA5D6A7),
    Color(0xFF4CAF50),
    Color(0xFF388E3C),
  ];

  @override
  void initState() {
    super.initState();

    // Gentle sway: -5° to +5°
    _swayCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _swayAnim = Tween<double>(begin: -0.087, end: 0.087).animate(
      CurvedAnimation(parent: _swayCtrl, curve: Curves.easeInOut),
    );

    // Leaf ticker ~60 fps
    _leafCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _leafCtrl.addListener(_updateLeaves);

    // Seed initial leaves scattered across screen
    for (int i = 0; i < 10; i++) {
      _leaves.add(_randomLeaf(startAnywhere: true));
    }
  }

  @override
  void dispose() {
    _swayCtrl.dispose();
    _leafCtrl.dispose();
    super.dispose();
  }

  _FallingLeaf _randomLeaf({bool startAnywhere = false}) {
    return _FallingLeaf(
      x: _rng.nextDouble(),
      y: startAnywhere ? _rng.nextDouble() : -0.1 - _rng.nextDouble() * 0.3,
      speed: 0.0015 + _rng.nextDouble() * 0.0025,
      angle: _rng.nextDouble() * pi * 2,
      spin: (_rng.nextBool() ? 1 : -1) * (0.01 + _rng.nextDouble() * 0.02),
      scale: 0.4 + _rng.nextDouble() * 0.6,
      drift: 0.05 + _rng.nextDouble() * 0.1,
      phase: _rng.nextDouble() * pi * 2,
      color: _leafColors[_rng.nextInt(_leafColors.length)],
    );
  }

  void _updateLeaves() {
    _tick += 0.016;
    setState(() {
      for (final leaf in _leaves) {
        leaf.y += leaf.speed;
        leaf.angle += leaf.spin;
        leaf.x += sin(_tick * 1.5 + leaf.phase) * leaf.drift * 0.005;
        leaf.x = leaf.x.clamp(0.0, 1.0);
      }
      _leaves.removeWhere((l) => l.y > 1.15);
      while (_leaves.length < 12) {
        _leaves.add(_randomLeaf());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── TOP: Animated plant canvas ─────────────────
        SizedBox(
          height: 280,
          child: LayoutBuilder(builder: (ctx, constraints) {
            return Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                // Falling leaves (behind plant)
                CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: _FallingLeavesPainter(leaves: _leaves),
                ),

                // Day badge — top-left corner
                Positioned(
                  top: 12,
                  left: 16,
                  child: _DayBadge(day: widget.plant.day),
                ),

                // Plant (swaying) — centred
                Center(
                  child: AnimatedBuilder(
                    animation: _swayAnim,
                    builder: (_, __) {
                      return Transform.rotate(
                        angle: _swayAnim.value,
                        alignment: Alignment.bottomCenter,
                        child: CustomPaint(
                          size: Size(
                            constraints.maxWidth * 0.55,
                            constraints.maxHeight * 0.92,
                          ),
                          painter: _PlantPainter(stage: widget.plant.stage),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),

        // ── BOTTOM: Stage progress + XP bar ───────────
        const SizedBox(height: 24),
        _StageInfo(plant: widget.plant),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ─────────────────────────────────────────
// Falling Leaves Painter
// ─────────────────────────────────────────
class _FallingLeavesPainter extends CustomPainter {
  final List<_FallingLeaf> leaves;
  const _FallingLeavesPainter({required this.leaves});

  @override
  void paint(Canvas canvas, Size size) {
    for (final leaf in leaves) {
      final cx = leaf.x * size.width;
      final cy = leaf.y * size.height;
      final s = leaf.scale * 22;

      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(leaf.angle);
      canvas.scale(s, s);

      final paint = Paint()..color = leaf.color.withOpacity(0.82);
      final path = Path()
        ..moveTo(0, -1)
        ..cubicTo(0.6, -0.6, 0.6, 0.4, 0, 1)
        ..cubicTo(-0.6, 0.4, -0.6, -0.6, 0, -1);
      canvas.drawPath(path, paint);

      // Midrib vein
      canvas.drawLine(
        const Offset(0, -0.85),
        const Offset(0, 0.85),
        Paint()
          ..color = Colors.white.withOpacity(0.35)
          ..strokeWidth = 0.08
          ..style = PaintingStyle.stroke,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_FallingLeavesPainter old) => true;
}

// ─────────────────────────────────────────
// Plant CustomPainter
// Uses PlantStage from plant_model.dart
// ─────────────────────────────────────────
class _PlantPainter extends CustomPainter {
  final PlantStage stage;
  const _PlantPainter({required this.stage});

  // Pot colours — defined locally so no AppColors dependency for these
  static const _potColor = Color(0xFF8D6E63);
  static const _soilColor = Color(0xFF6D4C41);
  static const _stemColor = Color(0xFF558B2F);
  static const _leafColor = Color(0xFF66BB6A);
  static const _leafLightColor = Color(0xFF81C784);

  @override
  void paint(Canvas canvas, Size size) {
    final potPaint = Paint()..color = _potColor;
    final soilPaint = Paint()..color = _soilColor;
    final stemPaint = Paint()
      ..color = _stemColor
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final leafPaint = Paint()..color = _leafColor;

    // ── Pot ───────────────────────────────
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          size.width * 0.25,
          size.height * 0.68,
          size.width * 0.5,
          size.height * 0.32,
        ),
        topLeft: const Radius.circular(4),
        topRight: const Radius.circular(4),
        bottomLeft: const Radius.circular(8),
        bottomRight: const Radius.circular(8),
      ),
      potPaint,
    );

    // Pot rim highlight
    canvas.drawLine(
      Offset(size.width * 0.22, size.height * 0.68),
      Offset(size.width * 0.78, size.height * 0.68),
      Paint()
        ..color = _potColor.withOpacity(0.55)
        ..strokeWidth = 6
        ..style = PaintingStyle.stroke,
    );

    // ── Soil ──────────────────────────────
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.22,
          size.height * 0.64,
          size.width * 0.56,
          size.height * 0.08,
        ),
        const Radius.circular(4),
      ),
      soilPaint,
    );

    // ── Stem ──────────────────────────────
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.64),
      Offset(size.width * 0.5, size.height * 0.2),
      stemPaint,
    );

    // ── Leaves ────────────────────────────
    _drawLeaf(canvas, leafPaint,
        Offset(size.width * 0.5, size.height * 0.45),
        Offset(size.width * 0.2, size.height * 0.3), 20);
    _drawLeaf(canvas, leafPaint,
        Offset(size.width * 0.5, size.height * 0.38),
        Offset(size.width * 0.78, size.height * 0.22), 20);

    final lightLeafPaint = Paint()..color = _leafLightColor;
    _drawLeaf(canvas, lightLeafPaint,
        Offset(size.width * 0.5, size.height * 0.28),
        Offset(size.width * 0.3, size.height * 0.16), 14);

    // ── Top sprout (only for mature / flowering) ──
    if (stage == PlantStage.mature || stage == PlantStage.flowering) {
      final sproutPaint = Paint()
        ..color = _leafLightColor
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.2),
        Offset(size.width * 0.42, size.height * 0.06),
        sproutPaint,
      );
      canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.2),
        Offset(size.width * 0.6, size.height * 0.04),
        sproutPaint,
      );

      // Sprout tip dots
      final dotPaint = Paint()..color = _leafLightColor;
      canvas.drawCircle(
          Offset(size.width * 0.42, size.height * 0.06), 4, dotPaint);
      canvas.drawCircle(
          Offset(size.width * 0.6, size.height * 0.04), 4, dotPaint);
    }

    // ── Flower (only for flowering) ───────
    if (stage == PlantStage.flowering) {
      _drawFlower(canvas, size);
    }
  }

  void _drawFlower(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.1);
    final petalPaint = Paint()..color = const Color(0xFFFFB300);
    final centerPaint = Paint()..color = const Color(0xFFFFF9C4);

    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i;
      final px = center.dx + cos(angle) * 10;
      final py = center.dy + sin(angle) * 10;
      canvas.drawCircle(Offset(px, py), 6, petalPaint);
    }
    canvas.drawCircle(center, 6, centerPaint);
  }

  void _drawLeaf(
    Canvas canvas,
    Paint paint,
    Offset base,
    Offset tip,
    double width,
  ) {
    final mid = Offset((base.dx + tip.dx) / 2, (base.dy + tip.dy) / 2);
    final perp = Offset(-(tip.dy - base.dy), tip.dx - base.dx);
    final len = perp.distance;
    final ctrl =
        Offset(mid.dx + perp.dx / len * width, mid.dy + perp.dy / len * width);

    final path = Path()
      ..moveTo(base.dx, base.dy)
      ..quadraticBezierTo(ctrl.dx, ctrl.dy, tip.dx, tip.dy)
      ..quadraticBezierTo(mid.dx, mid.dy, base.dx, base.dy);
    canvas.drawPath(path, paint);

    // Midrib vein
    canvas.drawLine(
      base,
      tip,
      Paint()
        ..color = Colors.white.withOpacity(0.3)
        ..strokeWidth = 1.2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_PlantPainter old) => old.stage != stage;
}

// ─────────────────────────────────────────
// Day Badge
// ─────────────────────────────────────────
class _DayBadge extends StatelessWidget {
  final int day;
  const _DayBadge({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.25)),
      ),
      child: Text('Day $day', style: AppTextStyles.badge),
    );
  }
}

// ─────────────────────────────────────────
// Stage Info: progress icons + name + XP bar
// ─────────────────────────────────────────
class _StageInfo extends StatelessWidget {
  final PlantModel plant;
  const _StageInfo({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: [
          // Stage icon progress row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _stageIcon(PlantStage.seed, plant.stage),
              _stageDivider(),
              _stageIcon(PlantStage.sprout, plant.stage),
              _stageDivider(),
              _stageIcon(PlantStage.youngPlant, plant.stage),
              _stageDivider(),
              _stageIcon(PlantStage.mature, plant.stage),
              _stageDivider(),
              _stageIcon(PlantStage.flowering, plant.stage),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Current stage pill
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'CURRENT STAGE',
                  style: AppTextStyles.label
                      .copyWith(fontSize: 9, letterSpacing: 1.2),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(plant.stageName, style: AppTextStyles.badge),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // XP bar
          _XpBar(xp: plant.xp, maxXp: plant.maxXp),
        ],
      ),
    );
  }

  Widget _stageIcon(PlantStage stage, PlantStage current) {
    final isActive = stage.index <= current.index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? AppColors.primary.withOpacity(0.15)
            : AppColors.xpBarBg,
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.taskUnchecked,
          width: 1.5,
        ),
      ),
      child: Icon(
        _iconForStage(stage),
        size: 14,
        color: isActive ? AppColors.primary : AppColors.textMuted,
      ),
    );
  }

  Widget _stageDivider() => Container(
        width: 16,
        height: 1.5,
        color: AppColors.divider,
      );

  IconData _iconForStage(PlantStage stage) {
    switch (stage) {
      case PlantStage.seed:
        return Icons.circle_outlined;
      case PlantStage.sprout:
        return Icons.spa_outlined;
      case PlantStage.youngPlant:
        return Icons.eco_outlined;
      case PlantStage.mature:
        return Icons.park_outlined;
      case PlantStage.flowering:
        return Icons.local_florist_outlined;
    }
  }
}

// ─────────────────────────────────────────
// XP Progress Bar
// ─────────────────────────────────────────
class _XpBar extends StatelessWidget {
  final int xp;
  final int maxXp;
  const _XpBar({required this.xp, required this.maxXp});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('XP Progress', style: AppTextStyles.label),
            Text('$xp / $maxXp XP', style: AppTextStyles.badge),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: maxXp > 0 ? (xp / maxXp).clamp(0.0, 1.0) : 0,
            minHeight: 6,
            backgroundColor: AppColors.xpBarBg,
            valueColor: const AlwaysStoppedAnimation(AppColors.xpBar),
          ),
        ),
      ],
    );
  }
}
