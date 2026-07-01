import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_textstyle.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text);
  final String text;
 
  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.label.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
    ));
  }
}