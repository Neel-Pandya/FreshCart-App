import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/modules/admin/category/models/category.dart';
import 'package:frontend/modules/admin/category/screens/update_category_screen.dart';
import 'package:get/get.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({super.key, required this.category});
  final Category category;

  void _handleDeleteCategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber_outlined, color: AppColors.error, size: 40),
        title: Text(
          'Delete Category',
          style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
        ),
        content: Text(
          'Are you sure you want to delete this category?',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),

        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              backgroundColor: Colors.transparent,
            ),
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {
              Get.back();
              Toaster.showSuccessMessage(
                context: context,
                message: 'Category deleted successfully',
              );
            },
            child: Text('Delete', style: AppTypography.bodyMedium.copyWith(color: AppColors.error)),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFCAC4D0), width: 1),
      ),
      contentPadding: const EdgeInsets.all(10),
      title: Text(
        category.name,
        style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
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
            icon: const Icon(FeatherIcons.trash2, color: AppColors.error),
          ),
        ],
      ),
    );
  }
}
