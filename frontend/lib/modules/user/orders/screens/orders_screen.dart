import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/user/orders/data/order_data.dart';
import 'package:frontend/modules/user/orders/widgets/order_item.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
        leading: const SizedBox(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemBuilder: (ctx, index) => OrderItem(order: orderData[index]),
                itemCount: orderData.length,
                separatorBuilder: (ctx, index) => const SizedBox(height: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
