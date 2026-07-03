import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:life_garden/core/routes/app_routes.dart';
import 'package:life_garden/core/service/onboarding_service.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> logoFade;
  late final Animation<double> logoScale;
  late final Animation<double> titleFade;
  late final Animation<double> titleScale;
  late final Animation<double> subtitleFade;
  late final Animation<double> subtitleScale;
  late final Animation<double> loaderFade;
  late final Animation<double> loaderScale;

  Timer? _navigationTimer;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    logoFade = _interval(0.0, 0.55);
    logoScale = _scaleInterval(0.0, 0.55, beginScale: 0.75);

    titleFade = _interval(0.18, 0.72);
    titleScale = _scaleInterval(0.18, 0.72, beginScale: 0.82);

    subtitleFade = _interval(0.32, 0.85);
    subtitleScale = _scaleInterval(0.32, 0.85, beginScale: 0.88);

    loaderFade = _interval(0.48, 1.0);
    loaderScale = _scaleInterval(0.48, 1.0, beginScale: 0.9);

    controller.forward();
    _navigationTimer =
        Timer(const Duration(seconds: 4), _navigateNext);
  }

  Animation<double> _interval(double begin, double end) {
    return CurvedAnimation(
      parent: controller,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
  }

  Animation<double> _scaleInterval(
    double begin,
    double end, {
    required double beginScale,
  }) {
    return Tween<double>(begin: beginScale, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(begin, end, curve: Curves.easeOutBack),
      ),
    );
  }

  Future<void> _navigateNext() async {
    final seen = await OnboardingService.hasSeenOnboarding();
    Get.offAllNamed(seen ? AppRoutes.login : AppRoutes.onboarding);
  }

  @override
  void onClose() {
    _navigationTimer?.cancel();
    controller.dispose();
    super.onClose();
  }
}