

import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';

import 'package:life_garden/core/widgets/header_widgets.dart';
import 'package:life_garden/core/widgets/plant_growth_widget.dart';
import 'package:life_garden/core/widgets/stats_row_widgets.dart';
import 'package:life_garden/core/widgets/success_banner_widget.dart';
import 'package:life_garden/core/widgets/today_task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends State<HomeScreen> {
  // int _selectedIndex = 0;
 
  // final List<_TaskItem> _tasks = [
  //   _TaskItem(title: 'Read Book', xp: 10, coins: 10, isDone: true),
  //   _TaskItem(title: 'Exercise', xp: 10, coins: 10, isDone: false),
  //   _TaskItem(title: 'Flutter Course', xp: 10, coins: 10, isDone: false),
  // ];
 
  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.screenPadding(context);
 
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.md),
                      HeaderWidget(),
                     
                      const SizedBox(height: AppSpacing.lg),
                     const StatsRowWidgets(),
                      const SizedBox(height: AppSpacing.lg),
                     const TodayTasksWidget(),
                      const SizedBox(height: AppSpacing.lg),
                      const PlantGrowthWidget(),
                      const SizedBox(height: AppSpacing.md),
                       SuccessBannerWidget(),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
            ),
          // BottomNavWidget(currentIndex: 0, onTap: (index){})    
            //  BottomNavWidget(
        //       currentIndex: 0,
        //       onTap: (index) {
        //         // Handle bottom navigation tap
        //       },
        //     ),
          ],
        ),
      ),
    );
  }
}

 
  // ── Header ──────────────────────────────────────────────────────────────────
  // Widget _buildHeader() {
  //   return Row(
  //     children: [
  //       Container(
  //         width: 44,
  //         height: 44,
  //         decoration: BoxDecoration(
  //           color: AppColors.primary.withOpacity(0.15),
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         child: const Center(
  //           child: Text('🌱', style: TextStyle(fontSize: 22)),
  //         ),
  //       ),
  //       const SizedBox(width: AppSpacing.sm),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: const [
  //                 Text(
  //                   'Good Morning ',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.w700,
  //                     color: AppColors.textPrimary,
  //                   ),
  //                 ),
  //                 Text('👋', style: TextStyle(fontSize: 20)),
  //               ],
  //             ),
  //             const Text(
  //               "Let's grow your life today!",
  //               style: TextStyle(
  //                 fontSize: 13,
  //                 color: AppColors.textSecondary,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Stack(
  //         clipBehavior: Clip.none,
  //         children: [
  //           Icon(Icons.notifications_none_rounded,
  //               size: 28, color: AppColors.textPrimary),
  //           Positioned(
  //             top: -2,
  //             right: -2,
  //             child: Container(
  //               width: 9,
  //               height: 9,
  //               decoration: const BoxDecoration(
  //                 color: Colors.red,
  //                 shape: BoxShape.circle,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
 
  // ── Stats Row ────────────────────────────────────────────────────────────────
  // Widget _buildStatsRow() {
  //   return Row(
  //     children: [
  //       Expanded(child: _buildStreakCard()),
  //       const SizedBox(width: AppSpacing.sm),
  //       Expanded(child: _buildLevelCard()),
  //       const SizedBox(width: AppSpacing.sm),
  //       Expanded(child: _buildCoinsCard()),
  //     ],
  //   );
  // }
 
  // Widget _buildStreakCard() {
  //   return Container(
  //     padding: const EdgeInsets.all(AppSpacing.md),
  //     decoration: BoxDecoration(
  //       color: AppColors.streakCard,
  //       borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text('🔥', style: TextStyle(fontSize: 24)),
  //         const SizedBox(height: AppSpacing.xs),
  //         const Text(
  //           '5 Days',
  //           style: TextStyle(
  //             fontSize: 17,
  //             fontWeight: FontWeight.w800,
  //             color: AppColors.fireOrange,
  //           ),
  //         ),
  //         const Text(
  //           'Current Streak',
  //           style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
  //         ),
  //         const SizedBox(height: AppSpacing.xs),
  //         Row(
  //           children: const [
  //             Text('Keep it up! ', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
  //             Text('🔥', style: TextStyle(fontSize: 10)),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
 
  // Widget _buildLevelCard() {
  //   return Container(
  //     padding: const EdgeInsets.all(AppSpacing.md),
  //     decoration: BoxDecoration(
  //       color: AppColors.levelCard,
  //       borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text('⭐', style: TextStyle(fontSize: 24)),
  //         const SizedBox(height: AppSpacing.xs),
  //         const Text(
  //           'Level 3',
  //           style: TextStyle(
  //             fontSize: 17,
  //             fontWeight: FontWeight.w800,
  //             color: AppColors.textPrimary,
  //           ),
  //         ),
  //         const Text(
  //           'XP 120/200',
  //           style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
  //         ),
  //         const SizedBox(height: AppSpacing.sm),
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(4),
  //           child: LinearProgressIndicator(
  //             value: 120 / 200,
  //             minHeight: 6,
  //             backgroundColor: AppColors.xpBarBg,
  //             valueColor: const AlwaysStoppedAnimation<Color>(AppColors.xpBar),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
 
  // Widget _buildCoinsCard() {
  //   return Container(
  //     padding: const EdgeInsets.all(AppSpacing.md),
  //     decoration: BoxDecoration(
  //       color: AppColors.coinsCard,
  //       borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text('🪙', style: TextStyle(fontSize: 24)),
  //         const SizedBox(height: AppSpacing.xs),
  //         const Text(
  //           '250',
  //           style: TextStyle(
  //             fontSize: 17,
  //             fontWeight: FontWeight.w800,
  //             color: AppColors.coinGold,
  //           ),
  //         ),
  //         const Text(
  //           'Coins',
  //           style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
  //         ),
  //         const SizedBox(height: AppSpacing.xs),
  //         Row(
  //           children: const [
  //             Text('Keep going! ', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
  //             Text('💚', style: TextStyle(fontSize: 10)),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
 
  // ── Today's Tasks ─────────────────────────────────────────────────────────
  // Widget _buildTodaysTasks() {
  //   return Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           const Text(
  //             "Today's Tasks",
  //             style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.w700,
  //               color: AppColors.textPrimary,
  //             ),
  //           ),
  //           GestureDetector(
  //             onTap: () {},
  //             child: Container(
  //               padding: const EdgeInsets.symmetric(
  //                   horizontal: AppSpacing.sm + 2, vertical: AppSpacing.xs + 2),
  //               decoration: BoxDecoration(
  //                 color: AppColors.primary,
  //                 borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
  //               ),
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: const [
  //                   Icon(Icons.add, color: Colors.white, size: 14),
  //                   SizedBox(width: 2),
  //                   Text(
  //                     'Add Task',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: AppSpacing.md),
  //       Container(
  //         decoration: BoxDecoration(
  //           color: AppColors.cardBg,
  //           borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withOpacity(0.04),
  //               blurRadius: 8,
  //               offset: const Offset(0, 2),
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           children: List.generate(_tasks.length, (i) {
  //             final task = _tasks[i];
  //             final isLast = i == _tasks.length - 1;
  //             return Column(
  //               children: [
  //                 _buildTaskTile(task, i),
  //                 if (!isLast)
  //                   const Divider(
  //                     height: 1,
  //                     indent: 56,
  //                     color: AppColors.divider,
  //                   ),
  //               ],
  //             );
  //           }),
  //         ),
  //       ),
  //     ],
  //   );
  // }
 
  // Widget _buildTaskTile(_TaskItem task, int index) {
  //   return InkWell(
  //     borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
  //     onTap: () {
  //       setState(() {
  //         _tasks[index] = _TaskItem(
  //           title: task.title,
  //           xp: task.xp,
  //           coins: task.coins,
  //           isDone: !task.isDone,
  //         );
  //       });
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(
  //           horizontal: AppSpacing.md, vertical: AppSpacing.sm + 4),
  //       child: Row(
  //         children: [
  //           AnimatedContainer(
  //             duration: const Duration(milliseconds: 200),
  //             width: 24,
  //             height: 24,
  //             decoration: BoxDecoration(
  //               color: task.isDone ? AppColors.taskChecked : Colors.transparent,
  //               border: Border.all(
  //                 color: task.isDone ? AppColors.taskChecked : AppColors.taskUnchecked,
  //                 width: 2,
  //               ),
  //               borderRadius: BorderRadius.circular(6),
  //             ),
  //             child: task.isDone
  //                 ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
  //                 : null,
  //           ),
  //           const SizedBox(width: AppSpacing.md),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   task.title,
  //                   style: TextStyle(
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.w600,
  //                     color: task.isDone
  //                         ? AppColors.textSecondary
  //                         : AppColors.textPrimary,
  //                     decoration: task.isDone
  //                         ? TextDecoration.lineThrough
  //                         : TextDecoration.none,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 2),
  //                 Row(
  //                   children: [
  //                     Text(
  //                       '+${task.xp} XP',
  //                       style: const TextStyle(
  //                         fontSize: 11,
  //                         color: AppColors.primary,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                     const Text(
  //                       '  •  ',
  //                       style: TextStyle(fontSize: 11, color: AppColors.textMuted),
  //                     ),
  //                     Text(
  //                       '+${task.coins} Coins',
  //                       style: const TextStyle(
  //                         fontSize: 11,
  //                         color: AppColors.coinGold,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const Text('🪴', style: TextStyle(fontSize: 20)),
  //           const SizedBox(width: AppSpacing.xs),
  //           const Icon(Icons.chevron_right_rounded,
  //               color: AppColors.textMuted, size: 20),
  //         ],
  //       ),
  //     ),
  //   );
  // }
 
  // ── Plant Growth ─────────────────────────────────────────────────────────
  // Widget _buildPlantGrowth() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: AppColors.plantBg,
  //       borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.04),
  //           blurRadius: 8,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Stack(
  //       children: [
  //         // Decorative plants background right side
  //         Positioned(
  //           right: 0,
  //           top: 0,
  //           bottom: 0,
  //           child: ClipRRect(
  //             borderRadius: const BorderRadius.only(
  //               topRight: Radius.circular(AppSpacing.cardRadius),
  //               bottomRight: Radius.circular(AppSpacing.cardRadius),
  //             ),
  //             child: Container(
  //               width: 160,
  //               decoration: const BoxDecoration(
  //                 gradient: LinearGradient(
  //                   colors: [Color(0x00E8F5E9), Color(0xFFB2DFDB)],
  //                   begin: Alignment.centerLeft,
  //                   end: Alignment.centerRight,
  //                 ),
  //               ),
  //               child: const _PlantIllustration(),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(AppSpacing.md),
  //           child: Row(
  //             children: [
  //               // Left content
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       children: const [
  //                         Text(
  //                           'Plant Growth',
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w700,
  //                             color: AppColors.textPrimary,
  //                           ),
  //                         ),
  //                         SizedBox(width: 4),
  //                         Text('🌿', style: TextStyle(fontSize: 16)),
  //                       ],
  //                     ),
  //                     const SizedBox(height: 4),
  //                     const Text(
  //                       'Keep completing tasks\nto grow your plant',
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         color: AppColors.textSecondary,
  //                         height: 1.4,
  //                       ),
  //                     ),
  //                     const SizedBox(height: AppSpacing.md),
  //                     Row(
  //                       children: [
  //                         Container(
  //                           padding: const EdgeInsets.symmetric(
  //                               horizontal: AppSpacing.sm,
  //                               vertical: AppSpacing.xs),
  //                           decoration: BoxDecoration(
  //                             color: AppColors.primary.withOpacity(0.15),
  //                             borderRadius:
  //                                 BorderRadius.circular(AppSpacing.buttonRadius),
  //                           ),
  //                           child: Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: const [
  //                               Text('🌱', style: TextStyle(fontSize: 12)),
  //                               SizedBox(width: 4),
  //                               Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text(
  //                                     'Stage 2',
  //                                     style: TextStyle(
  //                                       fontSize: 11,
  //                                       fontWeight: FontWeight.w700,
  //                                       color: AppColors.primaryDark,
  //                                     ),
  //                                   ),
  //                                   Text(
  //                                     'Young Plant',
  //                                     style: TextStyle(
  //                                       fontSize: 9,
  //                                       color: AppColors.textSecondary,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               // Circular progress
  //               const SizedBox(width: AppSpacing.md),
  //               _CircularGrowthIndicator(percent: 0.40),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
 
  // ── Success Banner ────────────────────────────────────────────────────────
  // Widget _buildSuccessBanner() {
  //   return Container(
  //     padding: const EdgeInsets.all(AppSpacing.md),
  //     decoration: BoxDecoration(
  //       color: AppColors.successBg,
  //       borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
  //     ),
  //     child: Row(
  //       children: [
  //         Container(
  //           width: 44,
  //           height: 44,
  //           decoration: BoxDecoration(
  //             color: AppColors.primary.withOpacity(0.2),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: const Center(
  //             child: Text('🪣', style: TextStyle(fontSize: 22)),
  //           ),
  //         ),
  //         const SizedBox(width: AppSpacing.md),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 children: const [
  //                   Text(
  //                     'Great job! ',
  //                     style: TextStyle(
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.w700,
  //                       color: AppColors.textPrimary,
  //                     ),
  //                   ),
  //                   Text('🎉', style: TextStyle(fontSize: 15)),
  //                 ],
  //               ),
  //               const Text(
  //                 "You're one step closer to\na beautiful garden!",
  //                 style: TextStyle(
  //                   fontSize: 12,
  //                   color: AppColors.textSecondary,
  //                   height: 1.4,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const Text('🌿', style: TextStyle(fontSize: 36)),
  //       ],
  //     ),
  //   );
  // }
 
  // ── Bottom Nav ────────────────────────────────────────────────────────────
//   Widget _buildBottomNav() {
//     final items = [
//       _NavItem(icon: Icons.home_rounded, label: 'Home'),
//       _NavItem(icon: Icons.local_florist_rounded, label: 'Garden'),
//       _NavItem(icon: Icons.check_circle_outline_rounded, label: 'Tasks'),
//       _NavItem(icon: Icons.person_outline_rounded, label: 'Profile'),
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
//                 onTap: () => setState(() => _selectedIndex = i),
//                 behavior: HitTestBehavior.opaque,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: AppSpacing.md, vertical: AppSpacing.xs),
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


 
// ── Data Models ──────────────────────────────────────────────────────────────
// class _TaskItem {
//   final String title;
//   final int xp;
//   final int coins;
//   final bool isDone;
 
//   const _TaskItem({
//     required this.title,
//     required this.xp,
//     required this.coins,
//     required this.isDone,
//   });
// }
 
// class _NavItem {
//   final IconData icon;
//   final String label;
 
//   const _NavItem({required this.icon, required this.label});
// }
 
// ── Circular Progress Indicator ───────────────────────────────────────────
// class _CircularGrowthIndicator extends StatelessWidget {
//   final double percent;
 
//   const _CircularGrowthIndicator({required this.percent});
 
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 80,
//       height: 80,
//       child: CustomPaint(
//         painter: _ArcPainter(percent: percent),
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 '${(percent * 100).toInt()}%',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               const Text(
//                 'Growth',
//                 style: TextStyle(
//                   fontSize: 10,
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
 
// class _ArcPainter extends CustomPainter {
//   final double percent;
 
//   const _ArcPainter({required this.percent});
 
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2 - 6;
 
//     // Background arc
//     final bgPaint = Paint()
//       ..color = AppColors.xpBarBg
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 8
//       ..strokeCap = StrokeCap.round;
 
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -math.pi * 0.75,
//       math.pi * 1.5,
//       false,
//       bgPaint,
//     );
 
//     // Progress arc
//     final progressPaint = Paint()
//       ..color = AppColors.primary
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 8
//       ..strokeCap = StrokeCap.round;
 
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -math.pi * 0.75,
//       math.pi * 1.5 * percent,
//       false,
//       progressPaint,
//     );
//   }
 
//   @override
//   bool shouldRepaint(_ArcPainter old) => old.percent != percent;
// }
 
// ── Plant Illustration ────────────────────────────────────────────────────
// class _PlantIllustration extends StatelessWidget {
//   const _PlantIllustration();
 
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: _PlantPainter(),
//     );
//   }
// }
 
// class _PlantPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..style = PaintingStyle.fill;
 
//     // Sky/cloud background
//     paint.color = const Color(0xFFE0F7FA);
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(0, 0, size.width, size.height * 0.65),
//         const Radius.circular(12),
//       ),
//       paint,
//     );
 
//     // Ground
//     paint.color = const Color(0xFF8D6E63);
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(size.width * 0.1, size.height * 0.62,
//             size.width * 0.8, size.height * 0.15),
//         const Radius.circular(8),
//       ),
//       paint,
//     );
 
//     // Pot
//     final potPaint = Paint()
//       ..color = const Color(0xFFBF8C60)
//       ..style = PaintingStyle.fill;
 
//     final potPath = Path()
//       ..moveTo(size.width * 0.25, size.height * 0.65)
//       ..lineTo(size.width * 0.2, size.height * 0.85)
//       ..lineTo(size.width * 0.8, size.height * 0.85)
//       ..lineTo(size.width * 0.75, size.height * 0.65)
//       ..close();
//     canvas.drawPath(potPath, potPaint);
 
//     // Pot rim
//     potPaint.color = const Color(0xFFD4956A);
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(size.width * 0.2, size.height * 0.63,
//             size.width * 0.6, size.height * 0.06),
//         const Radius.circular(4),
//       ),
//       potPaint,
//     );
 
//     // Stem
//     paint.color = const Color(0xFF388E3C);
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromLTWH(size.width * 0.47, size.height * 0.15,
//             size.width * 0.06, size.height * 0.5),
//         const Radius.circular(3),
//       ),
//       paint,
//     );
 
//     // Main leaf
//     _drawLeaf(canvas, size, size.width * 0.5, size.height * 0.2,
//         size.width * 0.38, -0.4, const Color(0xFF4CAF50));
 
//     // Left leaf
//     _drawLeaf(canvas, size, size.width * 0.5, size.height * 0.32,
//         size.width * 0.28, -0.7, const Color(0xFF66BB6A));
 
//     // Right leaf
//     _drawLeaf(canvas, size, size.width * 0.5, size.height * 0.28,
//         size.width * 0.28, 0.7, const Color(0xFF81C784));
 
//     // Small top leaf
//     _drawLeaf(canvas, size, size.width * 0.5, size.height * 0.12,
//         size.width * 0.24, 0.3, const Color(0xFF2E7D32));
//   }
 
//   void _drawLeaf(Canvas canvas, Size size, double x, double y,
//       double leafSize, double angle, Color color) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
 
//     canvas.save();
//     canvas.translate(x, y);
//     canvas.rotate(angle);
 
//     final path = Path()
//       ..moveTo(0, 0)
//       ..quadraticBezierTo(-leafSize * 0.5, -leafSize * 0.5, 0, -leafSize)
//       ..quadraticBezierTo(leafSize * 0.5, -leafSize * 0.5, 0, 0);
 
//     canvas.drawPath(path, paint);
//     canvas.restore();
//   }
 
//   @override
//   bool shouldRepaint(_PlantPainter old) => false;
// }
 
