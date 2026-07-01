import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_image.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/theme/app_textstyle.dart';

// ignore: unused_element
class GoogleButton extends StatelessWidget {
  const GoogleButton({required this.onPressed});
  final VoidCallback onPressed;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Simple "G" mark to avoid bundling brand image assets.
                    Image.asset(
                    AppImage.google,
                    width: 20,
    
                   ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Continue with Google',
              style: AppTextStyles.headingSm.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}