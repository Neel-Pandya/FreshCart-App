import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/providers/bottom_nav_provider.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/features/settings/widgets/setting_item.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _logout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(FeatherIcons.logOut, color: AppColors.error, size: 36),
          title: Text(
            'Logout',
            style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                backgroundColor: Colors.transparent,
              ),
              child: Text(
                'Cancel',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                Toaster.showSuccessMessage(context: context, message: 'Logout successfully');
                Navigator.of(dialogContext).pop();
                Future.delayed(const Duration(seconds: 2), () {
                  if (!context.mounted) return;
                  ref.read(bottomNavigationProvider.notifier).state = 0;
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(Routes.onBoarding, (route) => false);
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
                backgroundColor: Colors.transparent,
              ),
              child: Text(
                'Logout',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.error,
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: Text(
          'Settings',
          style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'General',
                  style: AppTypography.titleMediumEmphasized.copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 20),
                const SettingItem(
                  title: 'Edit Profile',
                  icon: FeatherIcons.user,
                  trailingIcon: FeatherIcons.chevronRight,
                ),
                const SizedBox(height: 20),
                const SettingItem(
                  title: 'Change Password',
                  icon: FeatherIcons.lock,
                  trailingIcon: FeatherIcons.chevronRight,
                ),
                const SizedBox(height: 30),
                Text(
                  'Preferences',
                  style: AppTypography.titleMediumEmphasized.copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: 'Logout',
                  icon: FeatherIcons.logOut,
                  iconColor: AppColors.error,
                  titleColor: AppColors.error,
                  onTap: () => _logout(context, ref),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
