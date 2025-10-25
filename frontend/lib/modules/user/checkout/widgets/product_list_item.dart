import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/user/cart/models/cart.dart';
import 'package:get/get.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.cart});
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(cart.imageUrl, height: 100, width: 70, fit: BoxFit.cover),
          ),
          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cart.productName,
                style: AppTypography.titleMediumEmphasized.copyWith(
                  color: Get.theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Qty: ',
                      style: AppTypography.bodyMedium.copyWith(
                        color: Get.theme.colorScheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: '${cart.quantity} × \u20B9${cart.productPrice.toStringAsFixed(0)}',
                      style: AppTypography.bodyMedium.copyWith(
                        color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            '\u20B9 ${cart.totalPrice.toStringAsFixed(0)}',
            style: AppTypography.bodyMedium.copyWith(color: Get.theme.colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}
