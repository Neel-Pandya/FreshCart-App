import 'package:flutter/material.dart';
import 'package:frontend/features/admin/category/widgets/add_category_form.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Category')),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: AddCategoryForm(),
          ),
        ),
      ),
    );
  }
}
