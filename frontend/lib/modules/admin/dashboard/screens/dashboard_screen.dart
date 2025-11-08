import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/admin/category/controllers/category_controller.dart';
import 'package:frontend/modules/admin/dashboard/data/analytic_data.dart';
import 'package:frontend/modules/admin/dashboard/widgets/dashboard_analytics.dart';
import 'package:frontend/modules/admin/orders/controller/admin_order_controller.dart';
import 'package:frontend/modules/admin/orders/widgets/order_list_item.dart';
import 'package:frontend/modules/admin/product/controller/product_controller.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final productsController = Get.put(ProductController(), permanent: true);
  final categoryController = Get.put(CategoryController(), permanent: true);
  final orderController = Get.put(AdminOrderController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              SizedBox(
                height: 380,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  physics: const NeverScrollableScrollPhysics(),
                  children: analyticData
                      .map((analytic) => DashboardAnalytics(analytic: analytic))
                      .toList(),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Recent Orders',
                style: AppTypography.bodyLargeEmphasized.copyWith(
                  color: Get.theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 18),

              Obx(
                () => orderController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : orderController.orders.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'No orders yet',
                          style: AppTypography.bodyMedium.copyWith(
                            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async => await orderController.fetchAllOrders(),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: orderController.orders.length > 5
                              ? 5
                              : orderController.orders.length,
                          physics: const ClampingScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final order = orderController.orders[index];
                            return OrderListItem(
                              order: order,
                              imageUrl: order.userProfile.isNotEmpty
                                  ? order.userProfile
                                  : 'assets/images/user/common_profile.png',
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
