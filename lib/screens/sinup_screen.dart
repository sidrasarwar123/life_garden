// lib/screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_garden/core/controller/auth_controller/sinup_controller.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/theme/app_textstyle.dart';
import 'package:life_garden/core/widgets/button/back_button.dart';
import 'package:life_garden/core/widgets/button/google_button.dart';
import 'package:life_garden/core/widgets/button/primary_button.dart';
import 'package:life_garden/core/widgets/divider/or_divider.dart';
import 'package:life_garden/core/widgets/illustrations/sprout_illustration.dart';
import 'package:life_garden/core/widgets/textfield/field_label.dart';
import 'package:life_garden/core/widgets/textfield/round_textfield.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // controller sirf ek baar create hoga (agar already put hai to same instance milega)
    Get.put(SignUpController());

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
                const AppBackButton(),

                // Sprout illustration
                const Center(child: SproutIllustration(size: 110)),
                const SizedBox(height: AppSpacing.lg),

                Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headingLg.copyWith(fontSize: 26),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Start your journey today and grow your\nbeautiful Life Garden.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMd,
                ),
                const SizedBox(height: AppSpacing.xl),

                FieldLabel('Full Name'),
                const SizedBox(height: AppSpacing.sm),
                RoundedTextField(
                  controller: controller.nameController,
                  hint: 'Enter your full name',
                  prefixIcon: Icons.person_outline_rounded,
                  textInputAction: TextInputAction.next,
                  validator: controller.validateName,
                ),
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
                const SizedBox(height: AppSpacing.md),

                FieldLabel('Confirm Password'),
                const SizedBox(height: AppSpacing.sm),
                Obx(
                  () => RoundedTextField(
                    controller: controller.confirmPasswordController,
                    hint: 'Re-enter your password',
                    prefixIcon: Icons.lock_outline_rounded,
                    obscureText: controller.obscureConfirmPassword.value,
                    textInputAction: TextInputAction.done,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureConfirmPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onPressed: controller.toggleObscureConfirmPassword,
                    ),
                    validator: controller.validateConfirmPassword,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                Obx(
                  () => PrimaryButton(
                    label: 'Create Account',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.createAccount,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                const OrDivider(),
                const SizedBox(height: AppSpacing.lg),

                GoogleButton(onPressed: () {}),
                const SizedBox(height: AppSpacing.xl),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ', style: AppTextStyles.bodyMd),
                    GestureDetector(
                      onTap: controller.goBackToLogin,
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