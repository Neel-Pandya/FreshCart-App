import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/models/admin_product.dart';

class ViewOrderItem extends StatelessWidget {
  const ViewOrderItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 1.25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(product.imageUrl, height: 100, width: 100, fit: BoxFit.cover),
          ),
          const SizedBox(height: 10),
          Text(
            'Name - ${product.name}',
            style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Text(
            'Price - \u20B9 ${product.price.toStringAsFixed(0)}',
            style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Text(
            'Category - ${product.category}',
            style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Text(
            'Quantity - ${product.quantity}',
            style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Text(
            'Total - \u20B9 ${(product.price * product.quantity).toStringAsFixed(0)}',
            style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
