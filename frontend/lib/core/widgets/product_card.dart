import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.category,
  });

  final String imageUrl;
  final String name;
  final double price;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: AppTypography.bodyMediumEmphasized.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 2),
        Text(category, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: 3),
        Text(
          '₹ ${price.toStringAsFixed(2)}',
          style: AppTypography.bodyMediumEmphasized.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
