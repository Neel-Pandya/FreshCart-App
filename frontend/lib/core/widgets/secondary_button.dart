import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:get/get.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.text, this.onPressed, this.icon});

  final void Function()? onPressed;
  final String text;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final style = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 10),
      backgroundColor: isDark
          ? theme.colorScheme.surfaceContainerHighest
          : theme.colorScheme.surface,
      shadowColor: Colors.transparent,
      overlayColor: Get.theme.colorScheme.onSurface.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isDark
              ? theme
                    .colorScheme
                    .outlineVariant // softer border in dark mode
              : AppColors.border, // normal outline in light mode
          width: 1,
        ),
      ),
    );

    final textStyle = AppTypography.bodyMediumEmphasized.copyWith(
      color: theme.colorScheme.onSurface, // always readable on surface
    );

    if (icon != null) {
      return ElevatedButton.icon(
        icon: icon,
        style: style,
        onPressed: onPressed ?? () {},
        label: Text(text, style: textStyle),
      );
    }

    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: style,
      child: Text(text, style: textStyle),
    );
  }
}
