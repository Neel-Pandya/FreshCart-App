import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/quantity_handler.dart';
import 'package:frontend/modules/user/cart/models/cart.dart';
import 'package:get/get.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.cart, this.onRemove, this.onQuantityChange});

  final Cart cart;
  final Function(String)? onRemove;
  final Function(String, int)? onQuantityChange;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  void _handleQuantityChange(int newQuantity) {
    if (newQuantity > widget.cart.stock) {
      Toaster.showErrorMessage(message: 'Only ${widget.cart.stock} items available');
      return;
    }
    widget.onQuantityChange?.call(widget.cart.productId, newQuantity);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.cart.imageUrl,
                    height: 100,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cart.productName,
                              style: AppTypography.titleSmallEmphasized.copyWith(
                                color: Get.theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '\u20B9 ${widget.cart.productPrice.toStringAsFixed(0)}',
                              style: AppTypography.bodySmall.copyWith(
                                color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Total: \u20B9 ${widget.cart.totalPrice.toStringAsFixed(0)}',
                              style: AppTypography.labelMedium.copyWith(
                                color: Get.theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!widget.cart.hasEnoughStock)
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Exceeds stock: ${widget.cart.stock} available',
                                  style: AppTypography.labelSmall.copyWith(color: AppColors.error),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      QuantityHandler(
                        width: 25,
                        height: 25,
                        quantity: widget.cart.quantity,
                        onIncrement: widget.cart.quantity < widget.cart.stock
                            ? () {
                                _handleQuantityChange(widget.cart.quantity + 1);
                              }
                            : null,
                        onDecrement: widget.cart.quantity > 1
                            ? () {
                                _handleQuantityChange(widget.cart.quantity - 1);
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            widget.onRemove?.call(widget.cart.productId);
          },
          icon: const Icon(FeatherIcons.trash2, color: AppColors.error),
        ),
      ],
    );
  }
}
