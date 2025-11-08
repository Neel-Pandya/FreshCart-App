import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/models/admin_order.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final AdminOrder order;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(order.items[0].imageUrl, height: 100, width: 100, fit: BoxFit.cover),
          const SizedBox(height: 10),
          Text(
            'Name - ${order.items[0].productName}',
            style: AppTypography.titleMedium.copyWith(color: Get.theme.colorScheme.onSurface),
          ),
          const SizedBox(height: 10),
          Text(
            'Price - ${order.items[0].price.toStringAsFixed(0)}',
            style: AppTypography.titleMedium.copyWith(color: Get.theme.colorScheme.onSurface),
          ),
          const SizedBox(height: 10),
          Text(
            'Quantity - ${order.items[0].quantity}',
            style: AppTypography.titleMedium.copyWith(color: Get.theme.colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}
