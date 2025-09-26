import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/common/widgets/change_password_form.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
        centerTitle: true,
      ),

      body: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(height: 1, thickness: 1, color: AppColors.border),
            SizedBox(height: 20),
            Padding(padding: EdgeInsets.symmetric(horizontal: 30), child: ChangePasswordForm()),
          ],
        ),
      ),
    );
  }
}
