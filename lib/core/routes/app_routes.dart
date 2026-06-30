import 'package:flutter/material.dart';
import 'package:life_garden/screens/add_new_task_screen.dart';
import 'package:life_garden/screens/main_screen.dart';
import 'package:life_garden/screens/sanctuary_screen.dart';
import '../../screens/onboarding_screen.dart';
import '../../screens/login_screen.dart';

 
class AppRoutes {
  static const String splash     = '/';           // ← initialRoute hamesha '/' hona chahiye
  static const String onboarding = '/onboarding';
  static const String login      = '/login';
  static const String home       = '/bottom_nav';
  static const String sanctuary  = '/sanctuary';
  static const String addNewTask = '/add_new_task';
 
  //splash yahan nahi — onGenerateRoute handle karega (themeToggle pass hoga)
  static Map<String, WidgetBuilder> routes = {
    onboarding : (context) => const OnboardingScreen(),
    login      : (context) => const LoginScreen(),
    home       : (context) => const MainScreen(),
    sanctuary  : (context) => const SanctuaryScreen(),
    addNewTask : (context) => const AddNewTaskScreen(),
  };
}
