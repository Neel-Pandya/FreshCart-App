import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/user/orders/controller/order_controller.dart';
import 'package:frontend/modules/user/orders/widgets/order_item.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late final OrderController orderController;

  @override
  void initState() {
    super.initState();
    orderController = Get.put(OrderController());
  }

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
          Expanded(
            child: Obx(
              () => orderController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : orderController.orders.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FeatherIcons.shoppingBag,
                            size: 64,
                            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No Orders Yet',
                            style: AppTypography.titleMedium.copyWith(
                              color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your orders will appear here',
                            style: AppTypography.bodyMedium.copyWith(
                              color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => orderController.fetchOrders(),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: orderController.orders.length,
                        itemBuilder: (context, index) {
                          return OrderItem(order: orderController.orders[index]);
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
