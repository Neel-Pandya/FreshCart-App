import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/user/orders/models/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(order.productImage, height: 100, width: 100, fit: BoxFit.cover),
          const SizedBox(height: 10),
          Text(
            'Name - ${order.productName}',
            style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Text(
            'Price - ${order.productAmount}',
            style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Text(
            'Quantity - ${order.quantity}',
            style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
