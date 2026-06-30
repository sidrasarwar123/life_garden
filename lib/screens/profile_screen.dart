import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/widgets/profile_achievements.dart';
import 'package:life_garden/core/widgets/profile_header.dart';
import 'package:life_garden/core/widgets/profile_settings.dart';
import 'package:life_garden/core/widgets/profile_sign_out_button.dart';

import 'package:life_garden/core/widgets/stats_row_widgets.dart';

 
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
 
  // ── Menu (left) bottom sheet ──────────────────────────────────────────────
  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const _MenuSheet(),
    );
  }
 
  // ── App Settings (right) bottom sheet ────────────────────────────────────
  void _openAppSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _AppSettingsSheet(),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
 
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: cs.onSurface),
          onPressed: () => _openMenu(context),
        ),
        title: Text(
          'Life Garden',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: cs.onSurface),
            onPressed: () => _openAppSettings(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding(context).copyWith(top: AppSpacing.sm),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(),
            SizedBox(height: AppSpacing.lg),
           StatsRowWidgets(),
            SizedBox(height: AppSpacing.lg),
            ProfileAchievements(),
            SizedBox(height: AppSpacing.lg),
            ProfileSettings(),
            SizedBox(height: AppSpacing.lg),
            ProfileSignOutButton(),
            SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
 
// ═══════════════════════════════════════════════════════════════════════════════
// Menu Sheet (hamburger icon)
// ═══════════════════════════════════════════════════════════════════════════════
 
class _MenuSheet extends StatelessWidget {
  const _MenuSheet();
 
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
 
    final items = [
      _MenuItem(icon: Icons.grid_view_rounded,      label: 'Routine',       onTap: () => Navigator.pop(context)),
      _MenuItem(icon: Icons.bar_chart_rounded,       label: 'Stats',         onTap: () => Navigator.pop(context)),
      _MenuItem(icon: Icons.eco_rounded,             label: 'Garden',        onTap: () => Navigator.pop(context)),
      _MenuItem(icon: Icons.person_rounded,          label: 'Profile',       onTap: () => Navigator.pop(context)),
      _MenuItem(icon: Icons.emoji_events_outlined,   label: 'Leaderboard',   onTap: () => Navigator.pop(context)),
      _MenuItem(icon: Icons.help_outline_rounded,    label: 'Help & Support',onTap: () => Navigator.pop(context)),
    ];
 
    return SafeArea(
      
      child:
       Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.md,
        ),
        child: SingleChildScrollView(scrollDirection: Axis.vertical, 
          child: Column(
            
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // handle
              Center(
                child: Container(
                  width: 40, height: 4,
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // app title row
              Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.plantBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.eco_rounded,
                        color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text('Life Garden',
                      style: tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      )),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              // divider
              Container(height: 1, color: AppColors.divider),
              const SizedBox(height: AppSpacing.sm),
              // nav items
              ...items.map((item) => _MenuTile(item: item)),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }
}
 
class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.label, required this.onTap});
}
 
class _MenuTile extends StatelessWidget {
  final _MenuItem item;
  const _MenuTile({required this.item});
 
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
 
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.plantBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, color: AppColors.primary, size: 18),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(item.label,
                style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
 
// ═══════════════════════════════════════════════════════════════════════════════
// App Settings Sheet (gear icon)
// ═══════════════════════════════════════════════════════════════════════════════
 
class _AppSettingsSheet extends StatefulWidget {
  const _AppSettingsSheet();
 
  @override
  State<_AppSettingsSheet> createState() => _AppSettingsSheetState();
}
 
class _AppSettingsSheetState extends State<_AppSettingsSheet> {
  bool _darkMode     = false;
  bool _soundEffects = true;
  bool _haptics      = true;
  String _language   = 'English';
 
  static const _languages = ['English', 'Urdu', 'Arabic', 'French', 'Spanish'];
 
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
 
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // handle
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('App Settings',
                style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.md),
 
            // settings card
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: [
                  // Dark Mode
                  _AppSettingToggle(
                    icon: Icons.dark_mode_outlined,
                    label: 'Dark Mode',
                    value: _darkMode,
                    onChanged: (v) => setState(() => _darkMode = v),
                  ),
                  Container(height: 1, margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md), color: AppColors.divider),
                  // Sound Effects
                  _AppSettingToggle(
                    icon: Icons.volume_up_outlined,
                    label: 'Sound Effects',
                    value: _soundEffects,
                    onChanged: (v) => setState(() => _soundEffects = v),
                  ),
                  Container(height: 1, margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md), color: AppColors.divider),
                  // Haptics
                  _AppSettingToggle(
                    icon: Icons.vibration_rounded,
                    label: 'Haptic Feedback',
                    value: _haptics,
                    onChanged: (v) => setState(() => _haptics = v),
                  ),
                  Container(height: 1, margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md), color: AppColors.divider),
                  // Language picker
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm + 2,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36, height: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.plantBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.language_rounded,
                              color: AppColors.primary, size: 18),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text('Language',
                              style: tt.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 14)),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _language,
                            style: tt.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            icon: const Icon(Icons.expand_more_rounded,
                                color: AppColors.primary, size: 18),
                            items: _languages
                                .map((l) => DropdownMenuItem(
                                      value: l,
                                      child: Text(l),
                                    ))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _language = v ?? _language),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // version info
            Center(
              child: Text('Life Garden v1.0.0',
                  style: tt.bodySmall?.copyWith(color: AppColors.textMuted)),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
 
class _AppSettingToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
 
  const _AppSettingToggle({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });
 
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
 
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.plantBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(label,
                style: tt.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 14)),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.primary,
            inactiveThumbColor: AppColors.textSecondary,
            inactiveTrackColor: AppColors.xpBarBg,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
