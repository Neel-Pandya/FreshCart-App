import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/modules/admin/user/models/user.dart';
import 'package:frontend/modules/admin/user/screens/update_user_screen.dart';
import 'package:get/get.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({super.key, required this.user});
  final User user;

  void _handleDeleteUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.warning_amber_outlined, color: AppColors.error),
        title: Text(
          'Delete User',
          style: AppTypography.titleLargeEmphasized.copyWith(color: AppColors.textPrimary),
        ),
        content: Text(
          textAlign: TextAlign.center,
          'Are you sure you want to delete this user?',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
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
              Toaster.showSuccessMessage(context: context, message: 'User deleted successfully');
              Get.back();
            },
            child: Text('Delete', style: AppTypography.bodyMedium.copyWith(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFCAC4D0), width: 1),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(user.imageUrl, height: 48, width: 48),
      ),
      title: Text(
        user.name,
        style: AppTypography.titleMedium.copyWith(color: AppColors.textPrimary),
      ),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <IconButton>[
          IconButton(
            onPressed: () {
              Get.to(() => UpdateUserScreen(user: user));
            },
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
          ),
          IconButton(
            onPressed: () => _handleDeleteUser(context),
            icon: const Icon(FeatherIcons.trash2, color: AppColors.error),
          ),
        ],
      ),
    );
  }
}
