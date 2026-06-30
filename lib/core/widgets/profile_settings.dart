import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
 
class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});
 
  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}
 
class _ProfileSettingsState extends State<ProfileSettings> {
  bool _darkMode = false;
 
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: AppColors.divider, width: 1),
          ),
          child: Column(
            children: [
              // ── Dark Mode toggle ──
              _SettingsToggleItem(
                icon: Icons.dark_mode_outlined,
                label: 'Dark Mode',
                value: _darkMode,
                onChanged: (v) => setState(() => _darkMode = v),
              ),
              // explicit divider — full width inside card
              _ItemDivider(),
              // ── Notifications ──
              _SettingsNavItem(
                icon: Icons.notifications_outlined,
                label: 'Notifications',
                onTap: () => _openNotifications(context),
              ),
              _ItemDivider(),
              // ── Privacy ──
              _SettingsNavItem(
                icon: Icons.lock_outline_rounded,
                label: 'Privacy',
                isLast: true,
                onTap: () => _openPrivacy(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
 
  // ── placeholder screens / bottom sheets ──────────────────────────────────
 
  void _openNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _NotificationsSheet(),
    );
  }
 
  void _openPrivacy(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _PrivacySheet(),
    );
  }
}
 
// ── Divider ──────────────────────────────────────────────────────────────────
 
class _ItemDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      color: AppColors.divider, // #E8F0E8 — always visible
    );
  }
}
 
// ── Toggle row ───────────────────────────────────────────────────────────────
 
class _SettingsToggleItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
 
  const _SettingsToggleItem({
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
          _IconBadge(icon: icon),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              label,
              style: tt.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
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
 
// ── Nav row ──────────────────────────────────────────────────────────────────
 
class _SettingsNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isLast;
 
  const _SettingsNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isLast = false,
  });
 
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
 
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: isLast
            ? const BorderRadius.vertical(
                bottom: Radius.circular(AppSpacing.cardRadius),
              )
            : BorderRadius.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 2,
          ),
          child: Row(
            children: [
              _IconBadge(icon: icon),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: tt.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
// ── Icon badge ────────────────────────────────────────────────────────────────
 
class _IconBadge extends StatelessWidget {
  final IconData icon;
  const _IconBadge({required this.icon});
 
  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
 
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isLight
            ? AppColors.plantBg
            : AppColors.primary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppColors.primary, size: 18),
    );
  }
}
 
// ── Notifications bottom sheet ────────────────────────────────────────────────
 
class _NotificationsSheet extends StatefulWidget {
  const _NotificationsSheet();
 
  @override
  State<_NotificationsSheet> createState() => _NotificationsSheetState();
}
 
class _NotificationsSheetState extends State<_NotificationsSheet> {
  bool _dailyReminder = true;
  bool _streakAlert = true;
  bool _achievements = false;
 
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
 
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Notifications',
              style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.md),
            _SheetToggle(
              label: 'Daily Reminder',
              subtitle: 'Get reminded to complete your habits',
              value: _dailyReminder,
              onChanged: (v) => setState(() => _dailyReminder = v),
            ),
            _SheetToggle(
              label: 'Streak Alerts',
              subtitle: 'Don\'t lose your streak!',
              value: _streakAlert,
              onChanged: (v) => setState(() => _streakAlert = v),
            ),
            _SheetToggle(
              label: 'Achievement Unlocked',
              subtitle: 'Get notified when you earn badges',
              value: _achievements,
              onChanged: (v) => setState(() => _achievements = v),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
 
// ── Privacy bottom sheet ──────────────────────────────────────────────────────
 
class _PrivacySheet extends StatefulWidget {
  const _PrivacySheet();
 
  @override
  State<_PrivacySheet> createState() => _PrivacySheetState();
}
 
class _PrivacySheetState extends State<_PrivacySheet> {
  bool _shareProgress = false;
  bool _publicProfile = false;
 
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
 
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Privacy',
              style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.md),
            _SheetToggle(
              label: 'Share Progress',
              subtitle: 'Allow friends to see your garden',
              value: _shareProgress,
              onChanged: (v) => setState(() => _shareProgress = v),
            ),
            _SheetToggle(
              label: 'Public Profile',
              subtitle: 'Anyone can find your profile',
              value: _publicProfile,
              onChanged: (v) => setState(() => _publicProfile = v),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Delete Account',
                  style: tt.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
 
// ── Shared toggle row for sheets ──────────────────────────────────────────────
 
class _SheetToggle extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
 
  const _SheetToggle({
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });
 
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
 
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: tt.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(subtitle, style: tt.bodySmall),
              ],
            ),
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