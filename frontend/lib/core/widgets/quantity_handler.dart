import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:get/get.dart';

class QuantityHandler extends StatelessWidget {
  const QuantityHandler({
    super.key,
    this.height,
    this.width,
    this.onDecrement,
    this.onIncrement,
    required this.quantity,
  });
  final double? height;
  final double? width;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final int quantity;

  Widget buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color backgroundColor,
    required Color iconColor,
    double size = 30,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? size,
        height: height ?? size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Get.theme.colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 15, color: iconColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        color: Get.theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildIconButton(
              icon: FeatherIcons.minus,
              onTap: onDecrement ?? () {},
              backgroundColor: Get.theme.colorScheme.surface,
              iconColor: Get.theme.colorScheme.onSurface,
            ),
            const SizedBox(width: 15),
            Text(
              '$quantity',
              style: AppTypography.labelMedium.copyWith(color: Get.theme.colorScheme.onSurface),
            ),
            const SizedBox(width: 15),
            buildIconButton(
              icon: FeatherIcons.plus,
              onTap: onIncrement ?? () {},
              backgroundColor: Get.theme.colorScheme.onSurface,
              iconColor: Get.theme.colorScheme.surface,
            ),
          ],
        ),
      ),
    );
  }
}
