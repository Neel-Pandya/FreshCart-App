import 'package:flutter/material.dart';
import 'package:frontend/core/models/admin_product.dart';
import 'package:frontend/modules/admin/product/widgets/update_product_form.dart';

class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Product')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: UpdateProductForm(product: product),
          ),
        ),
      ),
    );
  }
}
