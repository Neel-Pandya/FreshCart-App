import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/models/admin_product.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/product_card.dart';
import 'package:frontend/modules/admin/product/controller/product_controller.dart';
import 'package:frontend/modules/user/products/screens/detailed_product_screen.dart';
import 'package:get/get.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  final productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    await productController.fetchUserFavourites();
  }

  Future<void> _removeFromFavourites(Product product) async {
    final success = await productController.toggleFavourite(product.productId);
    if (success) {
      Toaster.showSuccessMessage(message: productController.responseMessage.value);
      await _loadFavourites();
    } else {
      Toaster.showErrorMessage(message: productController.errorMessage.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Obx(
            () => productController.isFavouritesLoading.value
                ? const Center(child: CircularProgressIndicator())
                : productController.favouriteProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FeatherIcons.heart,
                          size: 64,
                          color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Favourite Products',
                          style: Get.theme.textTheme.titleMedium?.copyWith(
                            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add products to your favourites to see them here',
                          style: Get.theme.textTheme.bodyMedium?.copyWith(
                            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _loadFavourites,
                    child: GridView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: productController.favouriteProducts.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 25,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final product = productController.favouriteProducts[index];
                        return Stack(
                          children: [
                            ProductCard(
                              product: product,
                              onTap: (Product product) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Get.to(() => const DetailedProductScreen(), arguments: product);
                              },
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () => _removeFromFavourites(product),
                                icon: const Icon(Icons.favorite, color: Colors.red),
                                style: IconButton.styleFrom(
                                  backgroundColor: Get.theme.colorScheme.surface,
                                  shape: const CircleBorder(),
                                ),
                              ),
                            ),
                          ],
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
