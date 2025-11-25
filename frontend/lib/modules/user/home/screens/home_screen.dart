import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/app_dialog.dart';
import 'package:frontend/core/widgets/product_card.dart';
import 'package:frontend/modules/admin/product/controller/product_controller.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:frontend/modules/user/home/widgets/home_header.dart';
import 'package:frontend/modules/user/products/screens/detailed_product_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final productController = Get.find<ProductController>();

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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HomeHeader(
                  name: controller.user.value?.name ?? '',
                  imageUrl: controller.user.value!.imageUrl,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Our Products',
                      style: AppTypography.bodyLargeEmphasized.copyWith(
                        color: Get.theme.colorScheme.onSurface,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      'See All',
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Obx(
                  () => Expanded(
                    child: productController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : productController.products.isEmpty
                        ? const Center(child: Text('No Products Available'))
                        : RefreshIndicator(
                            onRefresh: () async {
                              await productController.fetchProducts();
                            },
                            child: GridView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: productController.products.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 25,
                                childAspectRatio: 0.7,
                              ),
                              itemBuilder: (context, index) => ProductCard(
                                product: productController.products[index],
                                onTap: (product) =>
                                    Get.to(const DetailedProductScreen(), arguments: product),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
