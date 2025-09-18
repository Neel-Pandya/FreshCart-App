import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/models/admin_order.dart';
import 'package:frontend/modules/admin/orders/screens/view_order_screen.dart';
import 'package:get/get.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key, required this.order, required this.imageUrl});
  final Order order;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => ViewOrderScreen(order: order));
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(imageUrl, height: 48, width: 48, fit: BoxFit.cover),
      ),
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.border, width: 1.25),
      ),
      title: Text(
        order.orderId,
        style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
      ),

      subtitle: Text(
        order.orderedBy,
        style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
      ),

      trailing: Text(
        '\u20B9 ${order.totalAmount.toStringAsFixed(0)}',
        style: AppTypography.bodyMediumEmphasized.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}
