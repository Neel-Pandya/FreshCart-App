import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/common/auth/login/widgets/login_form.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          Get.offAllNamed(Routes.onBoarding);
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [_buildTitle(context), const SizedBox(height: 32), const LoginForm()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login Account',
          style: AppTypography.titleLargeEmphasized.copyWith(
            color: Get.theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Please login with registered account',
          style: AppTypography.bodyMedium.copyWith(
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
