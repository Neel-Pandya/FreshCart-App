import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/models/order.dart';
import 'package:get/get.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.20),
          width: 1.25,
        ),
      ),
      tileColor: Get.theme.colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(order.productImage, height: 60, width: 50, fit: BoxFit.cover),
      ),
      title: Text(
        order.productName,
        style: AppTypography.titleMediumEmphasized.copyWith(color: Get.theme.colorScheme.onSurface),
      ),
      subtitle: Text(
        'Qty - ${order.quantity}',
        style: AppTypography.bodyMedium.copyWith(
          color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
      trailing: Text(
        '₹ ${order.subTotal}',
        style: AppTypography.bodyMediumEmphasized.copyWith(color: Get.theme.colorScheme.onSurface),
      ),
    );
  }
}
