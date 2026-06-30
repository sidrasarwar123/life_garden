import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  static const double cardRadius = 20;
  static const double buttonRadius = 15;

  static EdgeInsets screenPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 360) {
      return const EdgeInsets.symmetric(horizontal: md);
    }
    if (width < 600) {
      return const EdgeInsets.symmetric(horizontal: lg);
    }

    return const EdgeInsets.symmetric(horizontal: xl);
  }
}
