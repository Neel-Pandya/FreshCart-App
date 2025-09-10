import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/features/cart/models/cart.dart';
import 'package:frontend/features/checkout/widgets/product_list_item.dart';

class ProductListing extends StatelessWidget {
  const ProductListing({super.key, required this.cart});
  final List<Cart> cart;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(), // or ClampingScrollPhysics()
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => ProductListItem(cart: cart[index]),
      separatorBuilder: (context, index) =>
          const Divider(height: 1, thickness: 1, color: AppColors.border),
      itemCount: cart.length,
    );
  }
}
