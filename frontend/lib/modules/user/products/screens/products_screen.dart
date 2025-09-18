import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/product_card.dart';
import 'package:frontend/modules/user/products/data/product_data.dart';
import 'package:frontend/modules/user/products/screens/detailed_product_screen.dart';
import 'package:frontend/modules/user/products/widgets/filter_sheet.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: AppColors.background,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (_) => const FilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: productsData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 25,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) => ProductCard(
                    product: productsData[index],
                    onTap: (product) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.to(() => DetailedProductScreen(product: product));
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
