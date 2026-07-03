import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_garden/core/controller/splash_controller.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/widgets/animated_plant_logo.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  static const _gradientStart = Color(0xFF2E7D32);
  static const _gradientEnd = Color(0xFF81C784);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final logoSize = size.width < 360 ? 104.0 : 128.0;
    final titleSize = size.width < 360 ? 32.0 : 36.0;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_gradientStart, Color(0xFF388E3C), _gradientEnd],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: -size.height * 0.08,
              left: -size.width * 0.15,
              child: _AmbientGlow(size: size.width * 0.7, opacity: 0.10),
            ),
            Positioned(
              bottom: size.height * 0.12,
              right: -size.width * 0.2,
              child: _AmbientGlow(size: size.width * 0.55, opacity: 0.07),
            ),
            SafeArea(
              child: Padding(
                padding: AppSpacing.screenPadding(context),
                child: Column(
                  children: [
                    const Spacer(flex: 3),
                    _AnimatedBlock(
                      fade: controller.logoFade,
                      scale: controller.logoScale,
                      child: AnimatedPlantLogo(size: logoSize),
                    ),
                    SizedBox(
                      height:
                          size.height < 640 ? AppSpacing.lg : AppSpacing.xl,
                    ),
                    _AnimatedBlock(
                      fade: controller.titleFade,
                      scale: controller.titleScale,
                      child: Text(
                        'Life Garden',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.8,
                          height: 1.05,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm + 2),
                    _AnimatedBlock(
                      fade: controller.subtitleFade,
                      scale: controller.subtitleScale,
                      child: Text(
                        'Grow Your Life',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.90),
                          letterSpacing: 0.3,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const Spacer(flex: 4),
                    _AnimatedBlock(
                      fade: controller.loaderFade,
                      scale: controller.loaderScale,
                      child: const _PremiumLoader(),
                    ),
                    SizedBox(
                      height:
                          size.height < 640 ? AppSpacing.lg : AppSpacing.xl,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedBlock extends StatelessWidget {
  const _AnimatedBlock({
    required this.fade,
    required this.scale,
    required this.child,
  });

  final Animation<double> fade;
  final Animation<double> scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fade,
      child: ScaleTransition(scale: scale, child: child),
    );
  }
}

class _PremiumLoader extends StatelessWidget {
  const _PremiumLoader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2.2,
            strokeCap: StrokeCap.round,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withValues(alpha: 0.92),
            ),
            backgroundColor: Colors.white.withValues(alpha: 0.18),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Loading',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.70),
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.white.withValues(alpha: opacity),
            Colors.white.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}