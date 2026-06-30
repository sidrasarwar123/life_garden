import 'package:flutter/material.dart';
import 'package:life_garden/core/routes/app_routes.dart';
import 'package:life_garden/core/theme/app_theme.dart';
import 'package:life_garden/screens/splash_screen.dart';
 
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LifeGardenApp());
}
 
class LifeGardenApp extends StatefulWidget {
  const LifeGardenApp({super.key});
 
  @override
  State<LifeGardenApp> createState() => _LifeGardenAppState();
}
 
class _LifeGardenAppState extends State<LifeGardenApp> {
  ThemeMode _themeMode = ThemeMode.system;
 
  void _toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Garden',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      themeAnimationDuration: const Duration(milliseconds: 350),
      themeAnimationCurve: Curves.easeInOutCubic,
 
      //  SplashScreen ko route ke zariye open karo
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
 
      //  onGenerateRoute — SplashScreen ko themeToggle pass karne ke liye
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.splash) {
          return MaterialPageRoute(
            builder: (_) => SplashScreen(onThemeToggle: _toggleThemeMode),
          );
        }
        return null; // baaki routes AppRoutes.routes handle karega
      },
    );
  }
}