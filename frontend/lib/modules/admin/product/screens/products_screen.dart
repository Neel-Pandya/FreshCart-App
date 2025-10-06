import 'package:flutter/material.dart';
import 'package:frontend/core/routes/admin_routes.dart';
import 'package:frontend/modules/admin/category/controllers/category_controller.dart';
import 'package:frontend/modules/admin/product/controller/product_controller.dart';
import 'package:frontend/modules/admin/product/widgets/product_list.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});
  final productController = Get.find<ProductController>();
  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AdminRoutes.addProduct);
          },
          shape: const CircleBorder(),
          elevation: 0,
          child: const Icon(Icons.add),
        ),

        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(20),
            child: productController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : productController.products.isEmpty
                ? const Center(child: Text('No products found. Add some products.'))
                : ProductList(),
          ),
        ),
      ),
    );
  }
}
