import 'package:flutter/material.dart';
import 'package:life_garden/core/widgets/bottom_nav_widget.dart';
import 'package:life_garden/screens/add_new_task_screen.dart';
import 'package:life_garden/screens/home_screen.dart';
import 'package:life_garden/screens/profile_screen.dart';
import 'package:life_garden/screens/sanctuary_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final pages = [
    const HomeScreen(),
    const SanctuaryScreen(),
    const AddNewTaskScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavWidget(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}