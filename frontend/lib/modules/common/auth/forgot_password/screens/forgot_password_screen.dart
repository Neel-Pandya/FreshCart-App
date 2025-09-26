import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/common/auth/forgot_password/widgets/forgot_password_form.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Forgot Password',
          style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
      ),
      body: const ForgotPasswordForm(),
    );
  }
}
