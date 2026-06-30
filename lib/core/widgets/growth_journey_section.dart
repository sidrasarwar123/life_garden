import 'package:flutter/material.dart';
import 'package:life_garden/core/model/plant_model.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/theme/app_textstyle.dart';


class GrowthJourneySection extends StatelessWidget {
  final List<GrowthMilestone> milestones;
  final VoidCallback onViewAll;

  const GrowthJourneySection({
    super.key,
    required this.milestones,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Growth Journey', style: AppTextStyles.headingMd),
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                'View All',
                style: AppTextStyles.badge.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Timeline
        ...List.generate(milestones.length, (i) => _MilestoneItem(
          milestone: milestones[i],
          isLast: i == milestones.length - 1,
        )),
      ],
    );
  }
}

class _MilestoneItem extends StatelessWidget {
  final GrowthMilestone milestone;
  final bool isLast;

  const _MilestoneItem({required this.milestone, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line + dot
          SizedBox(
            width: 32,
            child: Column(
              children: [
                _TimelineDot(
                  isCompleted: milestone.isCompleted,
                  isLocked: milestone.isLocked,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: milestone.isCompleted
                          ? AppColors.primary.withOpacity(0.3)
                          : AppColors.divider,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
              child: _MilestoneContent(milestone: milestone),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineDot extends StatelessWidget {
  final bool isCompleted;
  final bool isLocked;

  const _TimelineDot({required this.isCompleted, required this.isLocked});

  @override
  Widget build(BuildContext context) {
    if (isLocked) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.xpBarBg,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.taskUnchecked, width: 1.5),
        ),
        child: const Icon(Icons.lock_outline_rounded, size: 13, color: AppColors.textMuted),
      );
    }

    if (isCompleted) {
      return Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check_rounded, size: 16, color: Colors.white),
      );
    }

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.successBg,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: const Icon(Icons.eco_outlined, size: 14, color: AppColors.primary),
    );
  }
}

class _MilestoneContent extends StatelessWidget {
  final GrowthMilestone milestone;
  const _MilestoneContent({required this.milestone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: milestone.isLocked ? AppColors.xpBarBg : AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius - 4),
        border: milestone.isCompleted
            ? Border.all(color: AppColors.primary.withOpacity(0.2))
            : null,
        boxShadow: milestone.isLocked
            ? null
            : const [
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  milestone.title,
                  style: AppTextStyles.headingSm.copyWith(
                    color: milestone.isLocked ? AppColors.textMuted : null,
                  ),
                ),
              ),
              Text(
                milestone.date,
                style: AppTextStyles.bodySm.copyWith(fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            milestone.description,
            style: AppTextStyles.bodyMd.copyWith(
              color: milestone.isLocked ? AppColors.textMuted : null,
            ),
          ),

          if (milestone.isLocked) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Complete Advanced Mindset module to unlock this stage.',
                style: AppTextStyles.bodySm.copyWith(
                  color: AppColors.primary,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
