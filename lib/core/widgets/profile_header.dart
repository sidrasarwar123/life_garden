import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
 
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});
 
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
 
    return Center(
      child: Column(
        children: [
          // Avatar with edit button
          _EditableAvatar(),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Alex Rivera',
            style: tt.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          // Member since badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: AppColors.plantBg,
              borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
            ),
            child: Text(
              'Member since 2023',
              style: tt.bodySmall?.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 
class _EditableAvatar extends StatefulWidget {
  @override
  State<_EditableAvatar> createState() => _EditableAvatarState();
}
 
class _EditableAvatarState extends State<_EditableAvatar> {
  String? _localImagePath; // future: actual picked file path
 
  void _showEditOptions() {
    showModalBottomSheet(
      context: context,
      // BottomSheetTheme shape already set in AppTheme
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Profile Photo',
                style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: AppSpacing.md),
              _BottomSheetOption(
                icon: Icons.camera_alt_outlined,
                label: 'Take Photo',
                onTap: () {
                  Navigator.pop(ctx);
                  // TODO: integrate image_picker → ImageSource.camera
                },
              ),
              _BottomSheetOption(
                icon: Icons.photo_library_outlined,
                label: 'Choose from Gallery',
                onTap: () {
                  Navigator.pop(ctx);
                  // TODO: integrate image_picker → ImageSource.gallery
                },
              ),
              if (_localImagePath != null)
                _BottomSheetOption(
                  icon: Icons.delete_outline_rounded,
                  label: 'Remove Photo',
                  isDestructive: true,
                  onTap: () {
                    setState(() => _localImagePath = null);
                    Navigator.pop(ctx);
                  },
                ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
 
    return GestureDetector(
      onTap: _showEditOptions,
      child: Stack(
        children: [
          // Avatar ring + image
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: cs.primary, width: 3),
            ),
            child: CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.plantBg,
              backgroundImage: _localImagePath != null
                  ? NetworkImage(_localImagePath!) as ImageProvider
                  : const NetworkImage('https://i.pravatar.cc/150?img=47'),
            ),
          ),
          // Edit badge — bottom right
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.edit_rounded,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 
class _BottomSheetOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;
 
  const _BottomSheetOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });
 
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = isDestructive ? cs.error : cs.onSurface;
 
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm + 2,
          horizontal: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDestructive
                    ? cs.error.withValues(alpha: 0.1)
                    : AppColors.plantBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}