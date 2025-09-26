import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/common/onboarding/models/onboarding.dart';
import 'package:get/get.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({super.key, required this.item});

  final Onboarding item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 330,
          width: 330,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(31),
            border: Border.all(
              color: AppColors.border, // border color
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30), // apply same radius to image
            child: Image.asset(item.imageUrl, fit: BoxFit.contain),
          ),
        ),

        const SizedBox(height: 25),
        Text(
          item.heading,
          style: AppTypography.titleLargeEmphasized.copyWith(
            color: Get.theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        Text(
          item.description,
          style: AppTypography.labelMedium.copyWith(
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
