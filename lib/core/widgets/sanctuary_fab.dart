// import 'package:flutter/material.dart';
// import 'package:life_garden/core/theme/app_colors.dart';
// import 'package:life_garden/core/theme/app_textstyle.dart';

// class SanctuaryFab extends StatelessWidget {
//   final VoidCallback onTap;

//   const SanctuaryFab({super.key, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 52,
//         height: 52,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: const LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [AppColors.primaryLight, AppColors.primary],
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.primary.withOpacity(0.4),
//               blurRadius: 16,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
//       ),
//     );
//   }
// }
