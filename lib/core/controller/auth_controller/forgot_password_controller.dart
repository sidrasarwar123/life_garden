// lib/core/controllers/forgot_password_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool linkSent = false.obs;

  String? validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your email';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email address';
    return null;
  }

  Future<void> sendResetLink() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    linkSent.value = false;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      linkSent.value = true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Failed to Send',
        e.message ?? 'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goBackToLogin() => Get.back();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}