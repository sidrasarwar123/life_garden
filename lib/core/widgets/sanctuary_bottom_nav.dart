// import 'package:flutter/material.dart';
// import 'package:life_garden/core/theme/app_colors.dart';
// import 'package:life_garden/core/theme/app_textstyle.dart';


// class SanctuaryBottomNav extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;

//   const SanctuaryBottomNav({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   static const _items = [
//     (icon: Icons.home_rounded, label: 'Sanctu...'),
//     (icon: Icons.spa_outlined, label: 'Habits'),
//     (icon: Icons.download_outlined, label: 'Journal'),
//     (icon: Icons.diamond_outlined, label: 'Rewards'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 8, bottom: 12),
//       decoration: const BoxDecoration(
//         color: AppColors.background,
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.cardShadow,
//             blurRadius: 16,
//             offset: Offset(0, -4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: List.generate(_items.length, (i) {
//           final item = _items[i];
//           final isActive = i == currentIndex;
//           return GestureDetector(
//             onTap: () => onTap(i),
//             behavior: HitTestBehavior.opaque,
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: isActive ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     item.icon,
//                     size: 22,
//                     color: isActive ? AppColors.primary : AppColors.textMuted,
//                   ),
//                   const SizedBox(height: 3),
//                   Text(
//                     item.label,
//                     style: AppTextStyles.label.copyWith(
//                       color: isActive ? AppColors.primary : AppColors.textMuted,
//                       fontSize: 10,
//                       fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
