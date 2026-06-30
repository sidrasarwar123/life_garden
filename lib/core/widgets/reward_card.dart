import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';

class HarvestRewardCard extends StatelessWidget {
  final int estimatedCoins;
  const HarvestRewardCard({super.key, required this.estimatedCoins});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.levelCard,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius - 4),
        border: Border.all(color: AppColors.xpBar.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          // Coin icon circle
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.goldStar.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.goldStar.withOpacity(0.35),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.monetization_on,
              color: AppColors.goldStar,
              size: 32,
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ESTIMATED GAIN',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$estimatedCoins',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    const Text(
                      'Coins',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.coinGold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                const Text(
                  'Completing this task will\nnourish your digital garden.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
