import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/common/auth/forgot_password/widgets/reset_password_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Divider(height: 1, thickness: 1, color: AppColors.border),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: ResetPasswordForm(),
            ),
          ],
        ),
      ),
    );
  }
}
