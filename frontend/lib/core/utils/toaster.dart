import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toaster {
  static final _toastification = Toastification();

  static void _showMessage({
    required String title,
    required String message,
    required BuildContext context,
    required ToastificationType type,
    IconData? icon,
  }) {
    _toastification.show(
      context: context,
      title: Text(title),
      description: Text(message),
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 2),
      alignment: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 400),
      type: type,
      icon: Icon(icon),
      showIcon: icon != null,
      closeButton: ToastCloseButton(
        buttonBuilder: (context, onClose) {
          return IconButton(onPressed: onClose, icon: const Icon(Icons.close));
        },
      ),
      closeOnClick: false,
      pauseOnHover: false,
      applyBlurEffect: true,
    );
  }

  static void showSuccessMessage({
    String title = 'Success',
    required BuildContext context,
    required String message,
    IconData? icon = Icons.check_circle,
  }) {
    _showMessage(
      title: title,
      message: message,
      context: context,
      type: ToastificationType.success,
      icon: icon,
    );
  }

  static void showErrorMessage({
    String title = 'Error',
    required BuildContext context,
    required String message,
    IconData? icon = Icons.error,
  }) {
    _showMessage(
      title: title,
      message: message,
      context: context,
      type: ToastificationType.error,
      icon: icon,
    );
  }
}
