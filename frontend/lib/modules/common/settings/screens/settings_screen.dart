import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/controllers/bottom_nav_controller.dart';
import 'package:frontend/core/controllers/theme_controller.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/routes/user_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/app_dialog.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:frontend/modules/common/settings/widgets/setting_item.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final ThemeController _themeController = Get.find<ThemeController>();
  final AuthController _authController = Get.find<AuthController>();

  Future<void> _logout(BuildContext context) async {
    final result = await AppDialog.showLogoutDialog(
      context: context,
      onConfirm: () async {
        try {
          // Only perform logout, don't navigate here
          await _authController.logout();
        } catch (e) {
          // Handle logout error
          throw Exception('Logout failed');
        }
      },
    );

    // Handle navigation after dialog is completely closed
    if (result == true) {
      try {
        // Show success message
        Toaster.showSuccessMessage(message: 'Logout successful');

        // Reset bottom navigation controller if it exists
        try {
          final nav = Get.find<BottomNavController>();
          nav.setIndex(0);
        } catch (e) {
          // Controller might not exist in admin context, ignore
        }

        // Use WidgetsBinding to ensure navigation happens after current frame
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Clear the entire navigation stack and go to onboarding
          Get.offAllNamed(Routes.onBoarding);
        });
      } catch (e) {
        // If navigation fails, show error
        Toaster.showErrorMessage(message: 'Navigation error occurred');
      }
    } else if (result == false) {
      // Logout failed
      Toaster.showErrorMessage(message: 'Logout failed. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _authController.user.value!.role == 0
          ? AppBar(
              centerTitle: true,
              title: Text(
                'Settings',
                style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
              ),
            )
          : null,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'General',
                  style: AppTypography.titleMediumEmphasized.copyWith(
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: 'Edit Profile',
                  icon: FeatherIcons.user,
                  trailingIcon: Icons.chevron_right,
                  onTap: () => Get.toNamed(UserRoutes.editProfile),
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: 'Change Password',
                  icon: FeatherIcons.lock,
                  trailingIcon: Icons.chevron_right,
                  onTap: () => Get.toNamed(UserRoutes.changePassword),
                ),
                const SizedBox(height: 30),
                Text(
                  'Preferences',
                  style: AppTypography.titleMediumEmphasized.copyWith(
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: 'Dark Mode',
                  icon: FeatherIcons.moon,
                  trailingWidget: Obx(
                    () => Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: _themeController.isDarkMode.value,
                        onChanged: (value) => _themeController.toggleTheme(),
                        inactiveThumbColor: AppColors.iconColor,
                        trackOutlineColor: WidgetStateProperty.all(
                          Theme.of(context).brightness == Brightness.light
                              ? AppColors.iconColor
                              : Get.theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: 'Logout',
                  icon: Icons.logout,
                  iconColor: Get.theme.colorScheme.error,
                  titleColor: Get.theme.colorScheme.error,
                  onTap: () => _logout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
