import 'package:flutter/material.dart';

class TaskCategory {
  final String id;
  final String label;
  final IconData icon;
  final Color color;
  final Color bgColor;

  const TaskCategory({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    required this.bgColor,
  });

  static const List<TaskCategory> defaults = [
    TaskCategory(
      id: 'focus',
      label: 'Focus',
      icon: Icons.wb_sunny_outlined,
      color: Color(0xFF4CAF50),
      bgColor: Color(0xFFE8F5E9),
    ),
    TaskCategory(
      id: 'health',
      label: 'Health',
      icon: Icons.favorite_border,
      color: Color(0xFFE91E63),
      bgColor: Color(0xFFFCE4EC),
    ),
    TaskCategory(
      id: 'learning',
      label: 'Learning',
      icon: Icons.school_outlined,
      color: Color(0xFF9C27B0),
      bgColor: Color(0xFFF3E5F5),
    ),
  ];
}
