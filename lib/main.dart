// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_garden/core/controller/theme_controller.dart';
import 'package:life_garden/core/routes/app_page.dart';

import 'package:life_garden/core/routes/app_routes.dart';
import 'package:life_garden/core/theme/app_theme.dart';
import 'package:life_garden/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(ThemeController()); // App-wide controller, ek hi baar create

  runApp(const LifeGardenApp());
}

class LifeGardenApp extends StatelessWidget {
  const LifeGardenApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
          title: 'Life Garden',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeController.themeMode.value,
          initialRoute: AppRoutes.splash,
          getPages: AppPages.routes,
        ));
  }
}

