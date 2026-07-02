// lib/core/controllers/signup_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_garden/core/routes/app_routes.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  String? validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your name';
    return null;
  }

  String? validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your email';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email address';
    return null;
  }

  String? validatePassword(String? v) {
    if (v == null || v.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? v) {
    if (v != passwordController.text) return 'Passwords do not match';
    return null;
  }

Future<void> createAccount() async {
  if (!formKey.currentState!.validate()) return;

  isLoading.value = true;

  try {
    debugPrint("Step 1");

    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    debugPrint("Step 2");

    final user = credential.user!;

    debugPrint("Step 3");

    await user.updateDisplayName(nameController.text.trim());

   
    await FirebaseFirestore.instance
        .collection('userData')
        .doc(user.uid)
        .set({
      'userId': user.uid,
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    debugPrint('Account created: ${user.uid}');

    Get.snackbar(
      'Success',
      'Account created successfully',
      snackPosition: SnackPosition.TOP,
    );

    Get.offAllNamed(AppRoutes.home);
  } on FirebaseAuthException catch (e) {
    debugPrint("Error Code: ${e.code}");
    debugPrint("Error Message: ${e.message}");

    Get.snackbar(
      "Signup Failed",
      e.message ?? "Something went wrong",
      snackPosition: SnackPosition.TOP,
    );
  } catch (e) {
    debugPrint("General Error: $e");

    Get.snackbar(
      "Error",
      e.toString(),
      snackPosition: SnackPosition.TOP,
    );
  } finally {
    isLoading.value = false;
  }
}
  void goBackToLogin() => Get.back();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}