import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/models/admin_product.dart';
import 'package:frontend/modules/admin/product/screens/update_product_screen.dart';
import 'package:get/get.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.product});
  final Product product;

  void _handleDeleteProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.warning_amber_outlined,
          color: Theme.of(context).colorScheme.error,
          size: 40,
        ),
        title: Text(
          'Delete Product',
          style: AppTypography.titleLarge.copyWith(color: Theme.of(context).colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Are you sure you want to delete this product?',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              backgroundColor: Colors.transparent,
            ),
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTypography.bodyMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {
              Get.back();
              Toaster.showSuccessMessage(message: 'Product deleted successfully');
            },
            child: Text(
              'Delete',
              style: AppTypography.bodyMedium.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
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
        style: AppTypography.titleMedium.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),

      subtitle: Text(
        '\u20B9 ${product.price.toStringAsFixed(0)}',
        style: AppTypography.bodyMedium.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
            onPressed: () {
              Get.to(() => UpdateProductScreen(product: product));
            },
          ),
          IconButton(
            icon: Icon(FeatherIcons.trash2, color: Theme.of(context).colorScheme.error),
            onPressed: () => _handleDeleteProduct(context),
          ),
        ],
      ),
    );
  }
}
