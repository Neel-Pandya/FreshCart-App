import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/app_dialog.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/routes/admin_routes.dart';
import 'package:frontend/modules/admin/user/models/user.dart';
import 'package:frontend/modules/admin/user/controller/user_controller.dart';
import 'package:get/get.dart';

class UserListItem extends StatefulWidget {
  const UserListItem({super.key, required this.user});
  final User user;

  @override
  State<UserListItem> createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
  Future<void> _handleDeleteUser() async {
    final userController = Get.find<UserController>();

    await AppDialog.showDeleteDialog(
      context: context,
      itemName: 'user',
      onConfirm: () async {
        final success = await userController.deleteUser(widget.user.userId);
        if (success) {
          Toaster.showSuccessMessage(message: 'User deleted successfully');
        } else {
          Toaster.showErrorMessage(
            message: userController.errorMessage.value.isNotEmpty
                ? userController.errorMessage.value
                : 'Failed to delete user',
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Get.theme.brightness == Brightness.light
          ? Get.theme.colorScheme.surface
          : Get.theme.colorScheme.onSurface.withValues(alpha: 0.05),
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFCAC4D0), width: 1),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: widget.user.imageUrl.isNotEmpty
            ? Image.network(
                widget.user.imageUrl,
                height: 48,
                width: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, size: 24, color: Get.theme.colorScheme.onSurface),
                  );
                },
              )
            : Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, size: 24, color: Get.theme.colorScheme.onSurface),
              ),
      ),
      title: Text(
        widget.user.name,
        style: AppTypography.titleMedium.copyWith(color: Get.theme.colorScheme.onSurface),
      ),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <IconButton>[
          IconButton(
            onPressed: () {
              Get.toNamed(AdminRoutes.updateUser, arguments: widget.user);
            },
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
          ),
          IconButton(
            onPressed: _handleDeleteUser,
            icon: Icon(Icons.delete, color: Get.theme.colorScheme.error),
          ),
        ],
      ),
    );
  }
}
