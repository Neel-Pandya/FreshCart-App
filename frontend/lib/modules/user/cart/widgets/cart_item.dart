import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/quantity_handler.dart';
import 'package:frontend/modules/user/cart/models/cart.dart';
import 'package:get/get.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(cart.imageUrl, height: 100, width: 70, fit: BoxFit.cover),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cart.productName,
                          style: AppTypography.titleSmallEmphasized.copyWith(
                            color: Get.theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '\u20B9 ${cart.totalPrice.toStringAsFixed(0)}',
                          style: AppTypography.bodySmall.copyWith(
                            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 3),
                  const QuantityHandler(width: 25, height: 25),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(FeatherIcons.trash2, color: AppColors.error),
        ),
      ],
    );
  }
}
