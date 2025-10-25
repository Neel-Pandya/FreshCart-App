import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/models/admin_product.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/product_card.dart';
import 'package:frontend/modules/admin/product/controller/product_controller.dart';
import 'package:frontend/modules/user/products/screens/detailed_product_screen.dart';
import 'package:frontend/modules/user/products/widgets/filter_sheet.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Get.theme.colorScheme.surface,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (_) => const FilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormTextField(
                hintText: 'Search Products',
                prefixIcon: FeatherIcons.search,
                suffixIcon: FeatherIcons.filter,
                onSuffixTap: () => _showFilterSheet(context),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: productController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : productController.products.isEmpty
                    ? const Center(child: Text('No Products Available'))
                    : GridView.builder(
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
                          onTap: (Product product) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Get.to(() => const DetailedProductScreen(), arguments: product);
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
