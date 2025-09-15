import 'package:flutter/material.dart';
import 'package:frontend/features/admin/category/models/category.dart';
import 'package:frontend/features/admin/category/widgets/update_category_form.dart';

class UpdateCategoryScreen extends StatelessWidget {
  const UpdateCategoryScreen({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Category')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: UpdateCategoryForm(category: category),
        ),
      ),
    );
  }
}
