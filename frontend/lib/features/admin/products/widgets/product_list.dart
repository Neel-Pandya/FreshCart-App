import 'package:flutter/material.dart';
import 'package:frontend/features/admin/products/data/product_data.dart';
import 'package:frontend/features/admin/products/widgets/product_list_item.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: productsData.length,
      itemBuilder: (ctx, index) => ProductListItem(product: productsData[index]),
      separatorBuilder: (ctx, index) => const SizedBox(height: 15),
    );
  }
}
