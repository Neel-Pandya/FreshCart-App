import 'package:flutter/material.dart';
import 'package:frontend/features/admin/category/models/category.dart';
import 'package:frontend/features/admin/category/widgets/category_list_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.categories});
  final List<Category> categories;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: categories.length,
      itemBuilder: (ctx, index) => CategoryListItem(category: categories[index]),
      separatorBuilder: (ctx, index) => const SizedBox(height: 15),
    );
  }
}
