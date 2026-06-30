import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/theme/app_textstyle.dart';


class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border(
          left: BorderSide(color: AppColors.primary, width: 3),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Large quote mark
          Text(
            '\u201C',
            style: TextStyle(
              fontSize: 36,
              color: AppColors.primary.withOpacity(0.35),
              height: 0.8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(quote, style: AppTextStyles.quote),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Container(
                width: 20,
                height: 1.5,
                color: AppColors.primary.withOpacity(0.4),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                author,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
