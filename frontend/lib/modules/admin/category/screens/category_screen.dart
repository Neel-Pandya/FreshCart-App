import 'package:flutter/material.dart';
import 'package:frontend/core/routes/admin_routes.dart';
import 'package:frontend/modules/admin/category/controllers/category_controller.dart';
import 'package:frontend/modules/admin/category/widgets/category_list.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AdminRoutes.addCategory);
        },
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(20),
            child: controller.categoryList.isNotEmpty
                ? const CategoryList()
                : const Center(child: Text('No categories found')),
          ),
        ),
      ),
    );
  }
}
