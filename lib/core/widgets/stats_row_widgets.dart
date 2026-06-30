import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';

class StatsRowWidgets extends StatelessWidget {
  const StatsRowWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildStatsRow();
  }

   Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStreakCard()),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: _buildLevelCard()),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: _buildCoinsCard()),
      ],
    );
  }
 
  Widget _buildStreakCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.streakCard,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 24)),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            '5 Days',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.fireOrange,
            ),
          ),
          const Text(
            'Current Streak',
            style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.xs),
        Wrap(
  children: const [
    Text(
       'Keep it up!',
      style: TextStyle(
        fontSize: 8,
        color: AppColors.textSecondary,
      ),
    ),
    SizedBox(width: 2),
    Text('🔥', style: TextStyle(fontSize: 8)),
  ],
)
        ],
      ),
    );
  }
 
  Widget _buildLevelCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.levelCard,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('⭐', style: TextStyle(fontSize: 24)),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Level 3',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const Text(
            'XP 120/200',
            style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 120 / 200,
              minHeight: 6,
              backgroundColor: AppColors.xpBarBg,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.xpBar),
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildCoinsCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.coinsCard,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🪙', style: TextStyle(fontSize: 24)),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            '250',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.coinGold,
            ),
          ),
          const Text(
            'Coins',
            style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.xs),
        Wrap(
  children: const [
    Text(
      'Keep going!',
      style: TextStyle(
        fontSize: 8,
        color: AppColors.textSecondary,
      ),
    ),
    SizedBox(width: 2),
    Text('💚', style: TextStyle(fontSize: 8)),
  ],
)
        ],
      ),
    );
  }
}