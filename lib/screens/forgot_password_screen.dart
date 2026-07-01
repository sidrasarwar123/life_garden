import 'package:flutter/material.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/theme/app_textstyle.dart';

 
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
                const _BackButton(),
                const SizedBox(height: AppSpacing.xl),
 
                const Center(child: _WateringCanIllustration(size: 120)),
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
 
                _FieldLabel('Email Address'),
                const SizedBox(height: AppSpacing.sm),
                _RoundedTextField(
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
 
// ---------------------------------------------------------------------------
// Shared building blocks (mirroring the Login / Sign Up screens)
// ---------------------------------------------------------------------------
 
class _BackButton extends StatelessWidget {
  const _BackButton();
 
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: AppColors.secondary.withValues(alpha: 0.15),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => Navigator.of(context).maybePop(),
          child: const Padding(
            padding: EdgeInsets.all(AppSpacing.sm),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
 
class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;
 
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.label.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
 
class _RoundedTextField extends StatelessWidget {
  const _RoundedTextField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
    this.validator,
  });
 
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        validator: validator,
        style: AppTextStyles.bodyMd.copyWith(
          color: AppColors.textPrimary,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.bodyMd,
          filled: true,
          fillColor: AppColors.secondary.withValues(alpha: 0.12),
          prefixIcon: Icon(prefixIcon, color: AppColors.primary, size: 20),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            borderSide: const BorderSide(color: Color(0xFFB00020), width: 1.2),
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
class _WateringCanIllustration extends StatelessWidget {
  const _WateringCanIllustration({this.size = 120});
  final double size;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.plantBg,
      ),
      padding: EdgeInsets.all(size * 0.14),
      child: CustomPaint(painter: _WateringCanPainter()),
    );
  }
}
 
class _WateringCanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
 
    // --- Small sprout on the ground, bottom-left ---
    final stemPaint = Paint()
      ..color = AppColors.stem
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(w * 0.22, h * 0.92),
      Offset(w * 0.22, h * 0.68),
      stemPaint,
    );
 
    final leafPaint = Paint()..color = AppColors.leaf;
    final leaf = Path()
      ..moveTo(w * 0.22, h * 0.74)
      ..quadraticBezierTo(w * 0.02, h * 0.64, w * 0.08, h * 0.50)
      ..quadraticBezierTo(w * 0.26, h * 0.56, w * 0.22, h * 0.74)
      ..close();
    canvas.drawPath(leaf, leafPaint);
 
    final leaf2Paint = Paint()..color = AppColors.leafLight;
    final leaf2 = Path()
      ..moveTo(w * 0.22, h * 0.72)
      ..quadraticBezierTo(w * 0.40, h * 0.62, w * 0.36, h * 0.48)
      ..quadraticBezierTo(w * 0.20, h * 0.54, w * 0.22, h * 0.72)
      ..close();
    canvas.drawPath(leaf2, leaf2Paint);
 
    // ground
    final soilPaint = Paint()..color = AppColors.soil;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.04, h * 0.90, w * 0.40, h * 0.06),
        const Radius.circular(3),
      ),
      soilPaint,
    );
 
    // --- Watering can, top-right, tilted ---
    canvas.save();
    canvas.translate(w * 0.66, h * 0.30);
    canvas.rotate(-0.35);
 
    final canPaint = Paint()..color = AppColors.primaryDark;
    final canBody = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: w * 0.42, height: h * 0.26),
      const Radius.circular(10),
    );
    canvas.drawRRect(canBody, canPaint);
 
    // handle
    final handlePaint = Paint()
      ..color = AppColors.primaryDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(0, -h * 0.16), width: w * 0.26, height: h * 0.20),
      3.4,
      2.7,
      false,
      handlePaint,
    );
 
    // spout
    final spoutPaint = Paint()..color = AppColors.primaryDark;
    final spout = Path()
      ..moveTo(w * 0.20, -h * 0.04)
      ..lineTo(w * 0.40, -h * 0.14)
      ..lineTo(w * 0.42, -h * 0.08)
      ..lineTo(w * 0.22, h * 0.02)
      ..close();
    canvas.drawPath(spout, spoutPaint);
 
    canvas.restore();
 
    // --- Water droplets falling from spout toward sprout ---
    final dropPaint = Paint()..color = AppColors.primaryLight.withValues(alpha: 0.85);
    final dropCenters = [
      Offset(w * 0.50, h * 0.46),
      Offset(w * 0.42, h * 0.56),
      Offset(w * 0.34, h * 0.64),
    ];
    for (final c in dropCenters) {
      final drop = Path()
        ..moveTo(c.dx, c.dy - 5)
        ..quadraticBezierTo(c.dx + 5, c.dy + 4, c.dx, c.dy + 8)
        ..quadraticBezierTo(c.dx - 5, c.dy + 4, c.dx, c.dy - 5)
        ..close();
      canvas.drawPath(drop, dropPaint);
    }
  }
 
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}