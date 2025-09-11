import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.trailingIcon,
    this.iconColor,
    this.titleColor,
  });

  final String title;
  final IconData icon;
  final void Function()? onTap;
  final IconData? trailingIcon;
  final Color? iconColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.border, width: 1.25),
      ),
      tileColor: Colors.white,
      leading: Icon(icon, color: iconColor ?? AppColors.iconColor),
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(color: titleColor ?? AppColors.textSecondary),
      ),
      onTap: onTap ?? () {},
      trailing: trailingIcon != null
          ? Icon(trailingIcon, color: iconColor ?? AppColors.iconColor)
          : null,
    );
  }
}
