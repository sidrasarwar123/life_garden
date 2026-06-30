import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_garden/core/model/plant_model.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/theme/app_textstyle.dart';
import 'package:life_garden/core/widgets/growth_journey_section.dart';
import 'package:life_garden/core/widgets/plant_hero_section.dart';
import 'package:life_garden/core/widgets/quote_card.dart';


class SanctuaryScreen extends StatefulWidget {
  const SanctuaryScreen({super.key});

  @override
  State<SanctuaryScreen> createState() => _SanctuaryScreenState();
}

class _SanctuaryScreenState extends State<SanctuaryScreen> {
  
  int _selectedTab = 0;


  static final _milestones = [
    const GrowthMilestone(
      title: 'First Sprout',
      description: 'The initial habit sequence was completed for 7 days straight.',
      date: 'OCT 12',
      isCompleted: true,
    ),
    const GrowthMilestone(
      title: 'Consistent Care',
      description: 'Reached 21 days of morning meditation sessions.',
      date: 'NOV 24',
      isCompleted: true,
    ),
    const GrowthMilestone(
      title: 'Flowering',
      description: 'Complete Advanced Mindset module to unlock this stage.',
      date: '01/05/2025',
      isLocked: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6FAF6),
        extendBodyBehindAppBar: true,
        appBar: _SanctuaryAppBar(),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Space for AppBar
            const SliverToBoxAdapter(child: SizedBox(height: kToolbarHeight + 24)),

            // Hero — plant + stage + tabs
            SliverToBoxAdapter(
              child: PlantHeroSection(
                plant: PlantModel.sample,
                selectedTab: _selectedTab,
                onTabChanged: (i) => setState(() => _selectedTab = i),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.xxl + AppSpacing.xl,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Quote card
                  const QuoteCard(
                    quote:
                        'The best time to plant a tree was 20 years ago. The second best time is now.',
                    author: 'Chinese Proverb',
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Growth journey
                  GrowthJourneySection(
                    milestones: _milestones,
                    onViewAll: () {},
                  ),
                ]),
              ),
            ),
          ],
        ),
      
        // floatingActionButton: SanctuaryFab(onTap: () {}),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class _SanctuaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 160,
      leading: Padding(
        padding: const EdgeInsets.only(left: AppSpacing.lg),
        child: Row(
          children: [
            Icon(Icons.spa_rounded, color: AppColors.primary, size: 18),
            const SizedBox(width: 6),
            Text(
              'Sanctuary',
              style: AppTextStyles.headingSm.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.lg),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(color: AppColors.cardShadow, blurRadius: 8),
              ],
            ),
            child: const Icon(Icons.notifications_none_rounded,
                color: AppColors.textSecondary, size: 18),
          ),
        ),
      ],
    );
  }
}
