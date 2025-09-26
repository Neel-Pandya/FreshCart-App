import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:get/get.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.trailingIcon,
    this.iconColor,
    this.trailingWidget,

    this.titleColor,
  });

  final String title;
  final IconData icon;
  final void Function()? onTap;
  final IconData? trailingIcon;
  final Color? iconColor;
  final Color? titleColor;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.border, width: 1.25),
      ),
      tileColor: Get.theme.brightness == Brightness.light
          ? Colors.white
          : Get.theme.colorScheme.onSurface.withValues(alpha: 0.05),
      leading: Icon(
        icon,
        color:
            iconColor ??
            (Get.theme.brightness == Brightness.light
                ? AppColors.iconColor
                : Get.theme.colorScheme.onSurface),
      ),
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(
          color: titleColor ?? Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
      onTap: onTap ?? () {},
      trailing:
          trailingWidget ??
          Icon(
            trailingIcon,
            color:
                iconColor ??
                (Get.theme.brightness == Brightness.light
                    ? AppColors.iconColor
                    : Get.theme.colorScheme.onSurface),
          ),
    );
  }
}
