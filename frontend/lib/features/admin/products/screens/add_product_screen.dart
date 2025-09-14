import 'package:flutter/material.dart';
import 'package:frontend/features/admin/products/widgets/add_product_form.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 30), child: AddProductForm()),
        ),
      ),
    );
  }
}
