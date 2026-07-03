import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_garden/core/routes/app_routes.dart';
import 'package:life_garden/core/service/onboarding_service.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  static const int totalPages = 3;

  void onPageChanged(int index) => currentIndex.value = index;

  void nextPage() {
    if (currentIndex.value < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void skip() => _finishOnboarding();

  Future<void> _finishOnboarding() async {
    await OnboardingService.markOnboardingSeen();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}