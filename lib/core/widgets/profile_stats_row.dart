// import 'package:flutter/material.dart';
// import 'package:life_garden/core/theme/app_colors.dart';
// import 'package:life_garden/core/theme/app_spacing.dart';
 
// class ProfileStatsRow extends StatelessWidget {
//   const ProfileStatsRow({super.key});
 
//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       children: [
//         Expanded(
//           child: _StatCard(
//             icon: Icons.local_fire_department_rounded,
//             iconColor: AppColors.fireOrange,
//             lightBgColor: AppColors.streakCard,
//             value: '15',
//             label: 'Days',
//             subLabel: 'STREAK',
//           ),
//         ),
//         SizedBox(width: AppSpacing.sm),
//         Expanded(
//           child: _StatCard(
//             icon: Icons.star_rounded,
//             iconColor: AppColors.goldStar,
//             lightBgColor: AppColors.levelCard,
//             value: '12',
//             label: '',
//             subLabel: 'LEVEL',
//           ),
//         ),
//         SizedBox(width: AppSpacing.sm),
//         Expanded(
//           child: _StatCard(
//             icon: Icons.monetization_on_rounded,
//             iconColor: AppColors.coinGold,
//             lightBgColor: AppColors.coinsCard,
//             value: '1,250',
//             label: '',
//             subLabel: 'COINS',
//           ),
//         ),
//       ],
//     );
//   }
// }
 
// class _StatCard extends StatelessWidget {
//   final IconData icon;
//   final Color iconColor;
//   final Color lightBgColor; // used in light mode only
//   final String value;
//   final String label;
//   final String subLabel;
 
//   const _StatCard({
//     required this.icon,
//     required this.iconColor,
//     required this.lightBgColor,
//     required this.value,
//     required this.label,
//     required this.subLabel,
//   });
 
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final tt = Theme.of(context).textTheme;
//     final isLight = cs.brightness == Brightness.light;
 
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         vertical: AppSpacing.md,
//         horizontal: AppSpacing.sm,
//       ),
//       decoration: BoxDecoration(
//         // Light: each card gets its own warm tint; Dark: surfaceContainerHigh
//         color: isLight ? lightBgColor : cs.surfaceContainerHigh,
//         borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
//         border: Border.all(
//           color: cs.outlineVariant.withValues(alpha: 0.5),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: iconColor, size: 22),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: tt.titleMedium?.copyWith(
//               fontWeight: FontWeight.w700,
//               fontSize: 18,
//               // titleMedium color already set by AppTheme → onSurface
//             ),
//           ),
//           if (label.isNotEmpty)
//             Text(
//               label,
//               style: tt.bodySmall?.copyWith(fontSize: 11),
//             ),
//           Text(
//             subLabel,
//             style: tt.bodySmall?.copyWith(
//               // bodySmall color = textSecondary / darkTextSecondary via AppTheme
//               fontSize: 10,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }