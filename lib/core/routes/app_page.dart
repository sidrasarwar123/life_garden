import 'package:get/get.dart';
import 'package:life_garden/core/routes/app_routes.dart';
import 'package:life_garden/screens/add_new_task_screen.dart';
import 'package:life_garden/screens/forgot_password_screen.dart';
import 'package:life_garden/screens/login_screen.dart';
import 'package:life_garden/screens/main_screen.dart';
import 'package:life_garden/screens/onboarding_screen.dart';
import 'package:life_garden/screens/sanctuary_screen.dart';
import 'package:life_garden/screens/sinup_screen.dart';

import 'package:life_garden/screens/splash_screen.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),

    GetPage(
      name: AppRoutes.signup,
      page: () => const SignUpScreen(),
    ),

    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => const MainScreen(),
    ),

    GetPage(
      name: AppRoutes.sanctuary,
      page: () => const SanctuaryScreen(),
    ),

    GetPage(
      name: AppRoutes.addTask,
      page: () => const AddNewTaskScreen(),
    ),
  ];
}