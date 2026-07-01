// lib/core/controllers/splash_controller.dart
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:life_garden/core/routes/app_routes.dart';
import 'package:life_garden/core/service/onboarding_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // 4 second splash dikhane ke baad decision lo
    Timer(const Duration(seconds: 4), _decideNextScreen);
  }

  Future<void> _decideNextScreen() async {
    final hasSeenOnboarding = await OnboardingService.hasSeenOnboarding();
    final currentUser = FirebaseAuth.instance.currentUser;

    String nextRoute;

    if (!hasSeenOnboarding) {
      // Pehli baar app open hui hai
      nextRoute = AppRoutes.onboarding;
    } else if (currentUser != null) {
      // User pehle se login hai -> seedha home
      nextRoute = AppRoutes.home;
    } else {
      // Onboarding dekh chuka hai, lekin login nahi hai
      nextRoute = AppRoutes.login;
    }

    // Poori navigation stack clear karke target route pe jao
    Get.offAllNamed(nextRoute);
  }
}