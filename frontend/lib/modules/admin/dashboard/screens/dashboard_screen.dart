import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/app_dialog.dart';
import 'package:frontend/modules/admin/category/controllers/category_controller.dart';
import 'package:frontend/modules/admin/dashboard/controllers/dashboard_controller.dart';
import 'package:frontend/modules/admin/dashboard/models/analytic.dart';
import 'package:frontend/modules/admin/dashboard/widgets/dashboard_analytics.dart';
import 'package:frontend/modules/admin/orders/controller/admin_order_controller.dart';
import 'package:frontend/modules/admin/orders/widgets/order_list_item.dart';
import 'package:frontend/modules/admin/product/controller/product_controller.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final productsController = Get.put(ProductController(), permanent: true);
  final categoryController = Get.put(CategoryController(), permanent: true);
  final orderController = Get.put(AdminOrderController(), permanent: true);
  final dashboardController = Get.put(DashboardController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          AppDialog.showLogoutDialog(
            context: context,
            onConfirm: () async {
              await Get.find<AuthController>().logout();
              await Get.offAllNamed(Routes.onBoarding);
            },
          );
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: RefreshIndicator(
              onRefresh: () async {
                await dashboardController.fetchDashboardStats();
                await orderController.fetchAllOrders();
              },
              child: ListView(
                children: [
                  Obx(
                    () => dashboardController.isLoading
                        ? const SizedBox(
                            height: 380,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : SizedBox(
                            height: 380,
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                DashboardAnalytics(
                                  analytic: Analytic(
                                    title: 'Total Products',
                                    subtitle: '${dashboardController.stats?.totalProducts ?? 0}',
                                    iconPath: 'assets/icons/analytic_1.svg',
                                    iconColor: const Color(0xFF581313),
                                    iconBackground: const Color(0xFFF8D6D6),
                                  ),
                                ),
                                DashboardAnalytics(
                                  analytic: Analytic(
                                    title: 'Total Users',
                                    subtitle: '${dashboardController.stats?.totalUsers ?? 0}',
                                    iconPath: 'assets/icons/analytic_2.svg',
                                    iconColor: const Color(0xFF002B63),
                                    iconBackground: const Color(0xFFCCE1FE),
                                  ),
                                ),
                                DashboardAnalytics(
                                  analytic: Analytic(
                                    title: 'Total Orders',
                                    subtitle: '${dashboardController.stats?.totalOrders ?? 0}',
                                    iconPath: 'assets/icons/analytic_3.svg',
                                    iconColor: const Color(0xFF664D03),
                                    iconBackground: const Color(0xFFFFF3CD),
                                  ),
                                ),
                                DashboardAnalytics(
                                  analytic: Analytic(
                                    title: 'Total Payment',
                                    subtitle:
                                        '₹${dashboardController.stats?.totalPayment.toStringAsFixed(0) ?? '0'}',
                                    iconPath: 'assets/icons/analytic_4.svg',
                                    iconColor: const Color(0xFF0F5132),
                                    iconBackground: const Color(0xFFD1E7DD),
                                  ),
                                ),
                              ],
                            ),
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
                        : ListView.separated(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
