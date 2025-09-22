import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/modules/admin/category/screens/update_category_screen.dart';
import 'package:frontend/core/models/category.dart';
import 'package:get/get.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({super.key, required this.category, required this.onDelete});
  final Category category;
  final Future<void> Function() onDelete;

  void _handleDeleteCategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.warning_amber_outlined,
          color: Theme.of(context).colorScheme.error,
          size: 40,
        ),
        title: Text(
          'Delete Category',
          style: AppTypography.titleLarge.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: Text(
          'Are you sure you want to delete this category?',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),

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
            onPressed: () async {
              await onDelete();
              Get.back();
            },
            child: Text(
              'Delete',
              style: AppTypography.bodyMedium.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceEvenly,
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
      title: Text(
        category.name,
        style: AppTypography.titleMedium.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Get.to(() => UpdateCategoryScreen(category: category));
            },
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
          ),
          IconButton(
            onPressed: () => _handleDeleteCategory(context),
            icon: Icon(FeatherIcons.trash2, color: Theme.of(context).colorScheme.error),
          ),
        ],
      ),
    );
  }
}
