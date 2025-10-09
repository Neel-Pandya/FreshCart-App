import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:get/get.dart';

/// A comprehensive dialog utility class that provides common dialog patterns
/// used throughout the FreshCart application.
class AppDialog {
  /// Shows a confirmation dialog for destructive actions like delete, logout, etc.
  ///
  /// [context] - The build context
  /// [title] - The dialog title
  /// [content] - The dialog content/message
  /// [confirmText] - Text for the confirm button (default: 'Delete')
  /// [cancelText] - Text for the cancel button (default: 'Cancel')
  /// [icon] - Icon to display (default: warning icon)
  /// [iconColor] - Color of the icon (default: error color)
  /// [onConfirm] - Callback when confirm button is pressed (can be async)
  /// [isDestructive] - Whether this is a destructive action (affects button styling)
  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = 'Delete',
    String cancelText = 'Cancel',
    IconData? icon,
    Color? iconColor,
    required Future<void> Function() onConfirm,
    bool isDestructive = true,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // Prevent dismissing during operation
      builder: (dialogContext) => AlertDialog(
        icon: Icon(
          icon ?? Icons.warning_amber_outlined,
          color: iconColor ?? Get.theme.colorScheme.error,
          size: 36,
        ),
        title: Text(
          title,
          style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          style: AppTypography.bodyMedium.copyWith(
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            style: TextButton.styleFrom(
              foregroundColor: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
              backgroundColor: Colors.transparent,
            ),
            child: Text(
              cancelText,
              style: AppTypography.bodyMedium.copyWith(
                color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                await onConfirm();
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop(true);
                }
              } catch (e) {
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop(false);
                }
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: isDestructive
                  ? Get.theme.colorScheme.error
                  : Get.theme.colorScheme.primary,
              backgroundColor: Colors.transparent,
            ),
            child: Text(
              confirmText,
              style: AppTypography.bodyMedium.copyWith(
                color: isDestructive ? Get.theme.colorScheme.error : Get.theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows a success dialog with a checkmark icon.
  ///
  /// [context] - The build context
  /// [title] - The dialog title
  /// [content] - The dialog content/message
  /// [buttonText] - Text for the button (default: 'OK')
  /// [onButtonPressed] - Callback when button is pressed
  static Future<void> showSuccessDialog({
    required BuildContext context,
    required String title,
    required String content,
    String buttonText = 'OK',
    VoidCallback? onButtonPressed,
  }) async {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(Icons.check_circle_outline, color: Get.theme.colorScheme.primary, size: 36),
        title: Text(
          title,
          style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          style: AppTypography.bodyMedium.copyWith(
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onButtonPressed?.call();
            },
            style: TextButton.styleFrom(
              foregroundColor: Get.theme.colorScheme.primary,
              backgroundColor: Colors.transparent,
            ),
            child: Text(
              buttonText,
              style: AppTypography.bodyMedium.copyWith(
                color: Get.theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows an error dialog with an error icon.
  ///
  /// [context] - The build context
  /// [title] - The dialog title
  /// [content] - The dialog content/message
  /// [buttonText] - Text for the button (default: 'OK')
  /// [onButtonPressed] - Callback when button is pressed
  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String content,
    String buttonText = 'OK',
    VoidCallback? onButtonPressed,
  }) async {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(Icons.error_outline, color: Get.theme.colorScheme.error, size: 36),
        title: Text(
          title,
          style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          style: AppTypography.bodyMedium.copyWith(
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onButtonPressed?.call();
            },
            style: TextButton.styleFrom(
              foregroundColor: Get.theme.colorScheme.error,
              backgroundColor: Colors.transparent,
            ),
            child: Text(
              buttonText,
              style: AppTypography.bodyMedium.copyWith(
                color: Get.theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows an info dialog with an info icon.
  ///
  /// [context] - The build context
  /// [title] - The dialog title
  /// [content] - The dialog content/message
  /// [buttonText] - Text for the button (default: 'OK')
  /// [onButtonPressed] - Callback when button is pressed
  static Future<void> showInfoDialog({
    required BuildContext context,
    required String title,
    required String content,
    String buttonText = 'OK',
    VoidCallback? onButtonPressed,
  }) async {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(Icons.info_outline, color: Get.theme.colorScheme.secondary, size: 36),
        title: Text(
          title,
          style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          style: AppTypography.bodyMedium.copyWith(
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onButtonPressed?.call();
            },
            style: TextButton.styleFrom(
              foregroundColor: Get.theme.colorScheme.secondary,
              backgroundColor: Colors.transparent,
            ),
            child: Text(
              buttonText,
              style: AppTypography.bodyMedium.copyWith(
                color: Get.theme.colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows a loading dialog with a circular progress indicator.
  ///
  /// [context] - The build context
  /// [message] - Loading message to display (default: 'Loading...')
  ///
  /// Note: Remember to call [hideLoadingDialog] when the operation completes
  static Future<void> showLoadingDialog({
    required BuildContext context,
    String message = 'Loading...',
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
            const SizedBox(width: 16),
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(color: Get.theme.colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }

  /// Hides the currently displayed loading dialog.
  ///
  /// [context] - The build context
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// Shows a custom dialog with completely custom content.
  ///
  /// [context] - The build context
  /// [title] - The dialog title (optional)
  /// [content] - The dialog content widget
  /// [actions] - List of action widgets (optional)
  /// [icon] - Icon to display (optional)
  /// [iconColor] - Color of the icon (optional)
  static Future<T?> showCustomDialog<T>({
    required BuildContext context,
    String? title,
    required Widget content,
    List<Widget>? actions,
    IconData? icon,
    Color? iconColor,
  }) async {
    return showDialog<T>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: icon != null
            ? Icon(icon, color: iconColor ?? Get.theme.colorScheme.primary, size: 36)
            : null,
        title: title != null
            ? Text(
                title,
                style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
                textAlign: TextAlign.center,
              )
            : null,
        content: content,
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions:
            actions ??
            [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Get.theme.colorScheme.primary,
                  backgroundColor: Colors.transparent,
                ),
                child: Text(
                  'OK',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Get.theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
      ),
    );
  }

  /// Convenience method for logout confirmation dialog
  static Future<bool?> showLogoutDialog({
    required BuildContext context,
    required Future<void> Function() onConfirm,
  }) async {
    return showConfirmationDialog(
      context: context,
      title: 'Logout',
      content: 'Are you sure you want to logout?',
      confirmText: 'Logout',
      cancelText: 'Cancel',
      icon: Icons.logout,
      iconColor: Get.theme.colorScheme.error,
      onConfirm: onConfirm,
      isDestructive: true,
    );
  }

  /// Convenience method for delete confirmation dialog
  static Future<bool?> showDeleteDialog({
    required BuildContext context,
    required String itemName,
    required Future<void> Function() onConfirm,
  }) async {
    return showConfirmationDialog(
      context: context,
      title: 'Delete $itemName',
      content: 'Are you sure you want to delete this $itemName?',
      confirmText: 'Delete',
      cancelText: 'Cancel',
      onConfirm: onConfirm,
      isDestructive: true,
    );
  }
}
