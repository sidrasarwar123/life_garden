import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_garden/core/controller/auth_controller/login_controller.dart';

import 'package:life_garden/core/theme/app_image.dart';
import 'package:life_garden/core/widgets/button/google_button.dart';
import 'package:life_garden/core/widgets/textfield/field_label.dart';
import 'package:life_garden/core/widgets/textfield/round_textfield.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController()); // controller register, sirf ek baar create hoga

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding(context).copyWith(
            top: AppSpacing.lg,
            bottom: AppSpacing.lg,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: AssetImage(AppImage.login),
                  height: 160,
                  width: 160,
                ),
                const SizedBox(height: AppSpacing.lg),

                const Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),

                const Text(
                  'Continue your journey and grow your garden.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const SizedBox(height: AppSpacing.md),

                FieldLabel('Email Address'),
                const SizedBox(height: AppSpacing.sm),
                RoundedTextField(
                  controller: controller.emailController,
                  hint: 'Enter your email',
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: controller.validateEmail,
                ),
                const SizedBox(height: AppSpacing.md),

                FieldLabel('Password'),
                const SizedBox(height: AppSpacing.sm),
                Obx(
                  () => RoundedTextField(
                    controller: controller.passwordController,
                    hint: 'Create a password',
                    prefixIcon: Icons.lock_outline_rounded,
                    obscureText: controller.obscurePassword.value,
                    textInputAction: TextInputAction.next,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscurePassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onPressed: controller.toggleObscurePassword,
                    ),
                    validator: controller.validatePassword,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.goToForgotPassword,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                Obx(
                  () => SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed:
                          controller.isLoading.value ? null : controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.buttonRadius),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.4,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.textSecondary.withValues(alpha: 0.3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                      ),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color:
                              AppColors.textSecondary.withValues(alpha: 0.7),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.textSecondary.withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                GoogleButton(onPressed: () {}),
                const SizedBox(height: AppSpacing.xl),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New to the garden? ',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.goToSignUp,
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.eco_outlined,
                      size: 18,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Icon(
                      Icons.local_florist_outlined,
                      size: 18,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Icon(
                      Icons.spa_outlined,
                      size: 18,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
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