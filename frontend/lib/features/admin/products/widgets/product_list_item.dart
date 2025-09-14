import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/routes/admin_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/features/admin/products/models/product.dart';
import 'package:frontend/features/admin/products/screens/update_product_screen.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFCAC4D0), width: 1),
      ),
      contentPadding: const EdgeInsets.all(10),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(product.imageUrl, height: 50, width: 50, fit: BoxFit.cover),
      ),

      title: Text(
        product.name,
        style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
      ),

      subtitle: Text(
        '\u20B9 ${product.price.toStringAsFixed(0)}',
        style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
      ),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UpdateProductScreen(product: product)),
              );
            },
          ),
          IconButton(
            icon: const Icon(FeatherIcons.trash2, color: AppColors.error),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
