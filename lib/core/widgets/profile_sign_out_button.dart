import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
 
class ProfileSignOutButton extends StatelessWidget {
  const ProfileSignOutButton({super.key});
 
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
 
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showSignOutDialog(context),
        icon: Icon(Icons.logout_rounded, color: cs.error, size: 18),
        label: Text(
          'Sign Out',
          style: tt.labelLarge?.copyWith(
            color: cs.error,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          side: BorderSide(
            // error color from AppTheme: 0xFFB00020 light / 0xFFCF6679 dark
            color: cs.error.withValues(alpha: 0.4),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
        ),
      ),
    );
  }
 
  void _showSignOutDialog(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
 
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        // DialogTheme shape already set in AppTheme
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: FilledButton.styleFrom(
              backgroundColor: cs.error,
              foregroundColor: cs.onError,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}