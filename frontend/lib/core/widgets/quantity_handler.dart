import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';

class QuantityHandler extends StatefulWidget {
  const QuantityHandler({super.key, this.height, this.widtth});
  final double? height;
  final double? widtth;

  @override
  State<QuantityHandler> createState() => _QuantityHandlerState();
}

class _QuantityHandlerState extends State<QuantityHandler> {
  int quantity = 1;

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

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
        width: widget.widtth ?? size,
        height: widget.height ?? size,
        decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        child: Icon(icon, size: 15, color: iconColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        color: const Color(0xFFE0E0E0).withValues(alpha: 0.35),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildIconButton(
              icon: FeatherIcons.plus,
              onTap: increment,
              backgroundColor: Colors.white,
              iconColor: AppColors.textPrimary,
            ),
            const SizedBox(width: 15),
            Text(
              '$quantity',
              style: AppTypography.labelMedium.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(width: 15),
            buildIconButton(
              icon: FeatherIcons.minus,
              onTap: decrement,
              backgroundColor: AppColors.textPrimary,
              iconColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
