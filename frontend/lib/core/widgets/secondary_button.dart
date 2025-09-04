import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.text, this.onPressed, this.icon});
  final void Function()? onPressed;
  final String text;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 10),
      backgroundColor: AppColors.background,

      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
      ),
    );

    if (icon != null) {
      return ElevatedButton.icon(
        icon: icon,
        style: style,
        onPressed: onPressed ?? () {},
        label: Text(
          text,
          style: AppTypography.bodyMediumEmphasized.copyWith(color: AppColors.textPrimary),
        ),
      );
    }
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: style,
      child: Text(
        text,
        style: AppTypography.bodyMediumEmphasized.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}
