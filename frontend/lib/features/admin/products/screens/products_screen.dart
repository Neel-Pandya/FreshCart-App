import 'package:flutter/material.dart';
import 'package:frontend/core/routes/admin_routes.dart';
import 'package:frontend/features/admin/products/widgets/product_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AdminRoutes.addProduct);
          },
          shape: const CircleBorder(),
          elevation: 0,
          child: const Icon(Icons.add),
        ),

        body: const Padding(padding: EdgeInsets.all(20), child: ProductList()),
      ),
    );
  }
}
