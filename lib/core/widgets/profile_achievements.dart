import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
 
class ProfileAchievements extends StatelessWidget {
  const ProfileAchievements({super.key});
 
  static const _achievements = [
    _Achievement(icon: Icons.bolt_rounded,        label: 'Early Bird',   color: AppColors.goldStar),
    _Achievement(icon: Icons.spa_rounded,         label: 'Deep Focus',   color: AppColors.primary),
    _Achievement(icon: Icons.emoji_nature_rounded, label: 'Plant\nMaster', color: AppColors.leaf),
  ];
 
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Achievements',
              style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                // TextButton foreground comes from colorScheme.primary via AppTheme
              ),
              child: Text(
                'View All',
                style: tt.bodySmall?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _achievements
              .map((a) => _AchievementBadge(achievement: a))
              .toList(),
        ),
      ],
    );
  }
}
 
class _Achievement {
  final IconData icon;
  final String label;
  final Color color;
  const _Achievement({required this.icon, required this.label, required this.color});
}
 
class _AchievementBadge extends StatelessWidget {
  final _Achievement achievement;
  const _AchievementBadge({required this.achievement});
 
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
 
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: achievement.color.withValues(alpha: 0.12),
            border: Border.all(
              color: achievement.color.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Icon(achievement.icon, color: achievement.color, size: 30),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          achievement.label,
          textAlign: TextAlign.center,
          // bodySmall already carries correct secondary color via AppTheme
          style: tt.bodySmall?.copyWith(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}