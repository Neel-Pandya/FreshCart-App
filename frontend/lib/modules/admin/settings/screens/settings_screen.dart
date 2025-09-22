import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/routes/user_routes.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/modules/admin/settings/widgets/setting_item.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/core/controllers/bottom_nav_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(FeatherIcons.logOut, color: Theme.of(context).colorScheme.error, size: 36),
          title: Text(
            'Logout',
            style: AppTypography.titleLarge.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTypography.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                backgroundColor: Colors.transparent,
              ),
              child: Text(
                'Cancel',
                style: AppTypography.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final authController = Get.put(AuthController());
                authController.logout();
                Toaster.showSuccessMessage(message: 'Logout successful');
                Get.back();
                Future.delayed(const Duration(seconds: 2), () {
                  final nav = Get.find<BottomNavController>();
                  nav.setIndex(0);
                  Get.offAllNamed(Routes.onBoarding);
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
                backgroundColor: Colors.transparent,
              ),
              child: Text(
                'Logout',
                style: AppTypography.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'General',
                    style: AppTypography.titleMediumEmphasized.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SettingItem(
                    title: 'Edit Profile',
                    icon: FeatherIcons.user,
                    trailingIcon: FeatherIcons.chevronRight,
                    onTap: () => Get.toNamed(UserRoutes.editProfile),
                  ),
                  const SizedBox(height: 20),
                  SettingItem(
                    title: 'Change Password',
                    icon: FeatherIcons.lock,
                    trailingIcon: FeatherIcons.chevronRight,
                    onTap: () => Get.toNamed(UserRoutes.changePassword),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Preferences',
                    style: AppTypography.titleMediumEmphasized.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SettingItem(
                    title: 'Logout',
                    icon: FeatherIcons.logOut,
                    iconColor: Theme.of(context).colorScheme.error,
                    titleColor: Theme.of(context).colorScheme.error,
                    onTap: () => _logout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
