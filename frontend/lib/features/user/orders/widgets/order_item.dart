import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/features/user/orders/models/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.border, width: 1.25),
      ),
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(order.productImage, height: 60, width: 50, fit: BoxFit.cover),
      ),
      title: Text(
        order.productName,
        style: AppTypography.titleMediumEmphasized.copyWith(color: AppColors.textPrimary),
      ),
      subtitle: Text(
        'Qty - ${order.quantity}',
        style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
      ),
      trailing: Text(
        '₹ ${order.subTotal}',
        style: AppTypography.bodyMediumEmphasized.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}
