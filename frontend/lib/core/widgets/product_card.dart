import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/user/products/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.onTap});

  final Product product;
  final void Function(Product)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(product),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(product.imageUrl, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            style: AppTypography.bodyMediumEmphasized.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 2),
          Text(
            product.category,
            style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 3),
          Text(
            '₹ ${product.price.toStringAsFixed(0)}',
            style: AppTypography.bodyMediumEmphasized.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
