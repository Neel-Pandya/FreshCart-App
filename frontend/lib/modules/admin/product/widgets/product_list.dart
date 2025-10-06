import 'package:flutter/material.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/modules/admin/product/controller/product_controller.dart';
import 'package:frontend/modules/admin/product/widgets/product_list_item.dart';
import 'package:get/get.dart';

class ProductList extends StatelessWidget {
  ProductList({super.key});
  final _productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _productController.products.length,
      itemBuilder: (ctx, index) {
        final product = _productController.products[index];
        return ProductListItem(
          product: product,
          onDelete: () async {
            final ok = await _productController.deleteProduct(product.productId);
            if (ok) {
              Toaster.showSuccessMessage(message: 'Product deleted successfully');
            } else {
              Toaster.showErrorMessage(
                message: _productController.errorMessage.value.isNotEmpty
                    ? _productController.errorMessage.value
                    : 'Failed to delete product',
              );
            }
          },
        );
      },
      separatorBuilder: (ctx, index) => const SizedBox(height: 15),
    );
  }
}
