import 'package:flutter/material.dart';
import 'package:life_garden/core/model/task_category.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';


class CategoryChip extends StatelessWidget {
  final TaskCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? category.bgColor : AppColors.xpBarBg,
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          border: Border.all(
            color: isSelected ? category.color : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              size: 14,
              color: isSelected ? category.color : AppColors.textMuted,
            ),
            const SizedBox(width: AppSpacing.xs + 1),
            Text(
              category.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? category.color : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
