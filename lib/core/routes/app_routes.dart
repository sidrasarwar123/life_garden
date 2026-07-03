import 'package:get/get.dart';
import 'package:life_garden/core/controller/onboarding_controller.dart';
import 'package:life_garden/core/controller/splash_controller.dart';

import 'package:life_garden/screens/add_new_task_screen.dart';
import 'package:life_garden/screens/forgot_password_screen.dart';
import 'package:life_garden/screens/main_screen.dart';
import 'package:life_garden/screens/onboarding_screen.dart';
import 'package:life_garden/screens/login_screen.dart';
import 'package:life_garden/screens/sanctuary_screen.dart';
import 'package:life_garden/screens/sinup_screen.dart';
import 'package:life_garden/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot_password';
  static const String home = '/bottom_nav';
  static const String sanctuary = '/sanctuary';
  static const String addNewTask = '/add_new_task';

  static final List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SplashController());
      }),
    ),
    GetPage(
      name: onboarding,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OnboardingController());
      }),
    ),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: signup, page: () => const SignUpScreen()),
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(name: home, page: () => const MainScreen()),
    GetPage(name: sanctuary, page: () => const SanctuaryScreen()),
    GetPage(name: addNewTask, page: () => const AddNewTaskScreen()),
  ];
}