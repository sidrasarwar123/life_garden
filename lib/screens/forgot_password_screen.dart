// lib/screens/forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_garden/core/controller/auth_controller/forgot_password_controller.dart';

import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/theme/app_textstyle.dart';
import 'package:life_garden/core/widgets/button/back_button.dart';
import 'package:life_garden/core/widgets/button/primary_button.dart';
import 'package:life_garden/core/widgets/illustrations/WateringCanIllustration.dart';
import 'package:life_garden/core/widgets/textfield/field_label.dart';
import 'package:life_garden/core/widgets/textfield/round_textfield.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgotPasswordController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding(context).copyWith(
            top: AppSpacing.lg,
            bottom: AppSpacing.xl,
          ),
          child: Form(
            key: controller.formKey,
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
                  controller: controller.emailController,
                  hint: 'Enter your email',
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: controller.validateEmail,
                ),
                const SizedBox(height: AppSpacing.lg),

                Obx(() {
                  if (!controller.linkSent.value) return const SizedBox.shrink();
                  return Container(
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
                  );
                }),

                Obx(() => PrimaryButton(
                      label: 'Send Reset Link',
                      isLoading: controller.isLoading.value,
                      onPressed: controller.sendResetLink,
                    )),
                const SizedBox(height: AppSpacing.xl),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Remember your password? ', style: AppTextStyles.bodyMd),
                    GestureDetector(
                      onTap: () => Get.back(),
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