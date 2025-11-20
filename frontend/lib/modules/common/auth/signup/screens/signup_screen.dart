import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/common/auth/signup/widgets/signup_form.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create Account',
          style: AppTypography.titleLargeEmphasized.copyWith(
            color: Get.theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Start learning by creating an account',
          style: AppTypography.bodyMedium.copyWith(
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) => Get.offAllNamed(Routes.onBoarding),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [_buildTitle(context), const SizedBox(height: 32), const SignupForm()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
