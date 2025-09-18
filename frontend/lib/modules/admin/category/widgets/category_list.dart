import 'package:flutter/material.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/modules/admin/category/controllers/category_controller.dart';
import 'package:frontend/modules/admin/category/widgets/category_list_item.dart';
import 'package:get/get.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late final CategoryController _controller;
  @override
  void initState() {
    super.initState();
    _controller = Get.find<CategoryController>();
    _controller.fetchcategoryList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: _controller.categoryList.length,
              itemBuilder: (ctx, index) {
                final item = _controller.categoryList[index];
                return CategoryListItem(
                  category: item,
                  onDelete: () async {
                    final ok = await _controller.deleteCategory(item.id);
                    if (ok) {
                      Toaster.showSuccessMessage(message: 'Category deleted successfully');
                    } else {
                      Toaster.showErrorMessage(
                        message: _controller.error.value.isNotEmpty
                            ? _controller.error.value
                            : 'Failed to delete category',
                      );
                    }
                  },
                );
              },
              separatorBuilder: (ctx, index) => const SizedBox(height: 15),
            ),
    );
  }
}
