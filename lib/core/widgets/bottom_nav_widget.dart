// import 'package:flutter/material.dart';
// import 'package:life_garden/core/model/nav_item_model.dart';
// import 'package:life_garden/core/theme/app_colors.dart';
// import 'package:life_garden/core/theme/app_spacing.dart';

// class BottomNavWidget extends StatefulWidget {
//   const BottomNavWidget({super.key});

//   @override
//   State<BottomNavWidget> createState() => _BottomNavWidgetState();
// }

// class _BottomNavWidgetState extends State<BottomNavWidget> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       NavItemModel(icon: Icons.home_rounded, label: 'Home'),
//       NavItemModel(icon: Icons.local_florist_rounded, label: 'Garden'),
//       NavItemModel(icon: Icons.check_circle_outline_rounded, label: 'Tasks'),
//       NavItemModel(icon: Icons.person_outline_rounded, label: 'Profile'),
//     ];

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: List.generate(items.length, (i) {
//               final item = items[i];
//               final isSelected = i == _selectedIndex;

//               return GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onTap: () {
//                   setState(() {
//                     _selectedIndex = i;
//                   });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: AppSpacing.md,
//                     vertical: AppSpacing.xs,
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         item.icon,
//                         size: 26,
//                         color: isSelected
//                             ? AppColors.primary
//                             : AppColors.textMuted,
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         item.label,
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: isSelected
//                               ? AppColors.primary
//                               : AppColors.textMuted,
//                           fontWeight: isSelected
//                               ? FontWeight.w600
//                               : FontWeight.normal,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:life_garden/core/model/nav_item_model.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';

class BottomNavWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      NavItemModel(icon: Icons.home_rounded, label: 'Home'),
      NavItemModel(icon: Icons.local_florist_rounded, label: 'Garden'),
      NavItemModel(icon: Icons.check_circle_outline_rounded, label: 'Tasks'),
      NavItemModel(icon: Icons.person_outline_rounded, label: 'Profile'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final item = items[i];
              final isSelected = i == currentIndex;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(i),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 26,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textMuted,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textMuted,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}