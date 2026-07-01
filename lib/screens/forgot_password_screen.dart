import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/theme/app_textstyle.dart';
import 'package:life_garden/core/widgets/button/back_button.dart';
import 'package:life_garden/core/widgets/illustrations/WateringCanIllustration.dart';
import 'package:life_garden/core/widgets/textfield/field_label.dart';
import 'package:life_garden/core/widgets/textfield/round_textfield.dart';

 
/// Premium Forgot Password screen for Life Garden.
/// Reuses the exact same tokens (AppColors / AppSpacing / AppTextStyles)
/// and component styling as the Login / Sign Up screens.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
 
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}
 
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
 
  bool _isLoading = false;
  bool _linkSent = false;
 
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
 
  Future<void> _onSendResetLink() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // TODO: hook up to your auth/repository layer.
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _linkSent = true;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding(context).copyWith(
            top: AppSpacing.lg,
            bottom: AppSpacing.xl,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.sm),
                const AppBackButton(),
                const SizedBox(height: AppSpacing.xl),
 
                const Center(child: WateringCanIllustration(size: 120)),
                const SizedBox(height: AppSpacing.lg),
 
                Text(
                  'Forgot Password?',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headingLg.copyWith(fontSize: 26),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  "Don't worry! Enter your email address and\n"
                  "we'll send you a password reset link so you\n"
                  "can continue growing your Life Garden.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMd,
                ),
                const SizedBox(height: AppSpacing.xl),
 
                FieldLabel('Email Address'),
                const SizedBox(height: AppSpacing.sm),
                RoundedTextField(
                  controller: _emailController,
                  hint: 'Enter your email',
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    if (!emailRegex.hasMatch(v.trim())) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
 
                if (_linkSent)
                  Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.successBg,
                      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'Reset link sent! Check your inbox.',
                            style: AppTextStyles.bodyMd.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
 
                _PrimaryButton(
                  label: 'Send Reset Link',
                  isLoading: _isLoading,
                  onPressed: _onSendResetLink,
                ),
                const SizedBox(height: AppSpacing.xl),
 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Remember your password? ', style: AppTextStyles.bodyMd),
                    GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Text(
                        'Log In',
                        style: AppTextStyles.headingSm.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 

 
class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });
 
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Text(
                label,
                style: AppTextStyles.headingSm.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
      ),
    );
  }
}
 
/// Cute watering can pouring water onto a small sprout.
/// Pure CustomPaint, no external assets required.
