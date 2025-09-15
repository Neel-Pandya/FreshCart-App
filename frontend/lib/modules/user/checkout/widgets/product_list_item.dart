import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/user/cart/models/cart.dart';

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
                style: AppTypography.titleMediumEmphasized.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 5),
              Text(
                cart.quantity.toString(),
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),

          const Spacer(),

          Text(
            '\u20B9 ${cart.totalPrice.toStringAsFixed(0)}',
            style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
