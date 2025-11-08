import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/admin/orders/controller/admin_order_controller.dart';
import 'package:frontend/modules/admin/orders/widgets/order_list_item.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminOrderController());

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.orders.isEmpty
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
                        'Orders will appear here when users place them',
                        style: AppTypography.bodyMedium.copyWith(
                          color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => controller.fetchAllOrders(),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index) {
                        final order = controller.orders[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: OrderListItem(
                            order: order,
                            imageUrl: order.userProfile.isNotEmpty
                                ? order.userProfile
                                : 'assets/images/user/common_profile.png',
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
