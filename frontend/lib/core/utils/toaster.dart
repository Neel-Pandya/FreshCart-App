import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toaster {
  static final _toastification = Toastification();
  static ToastificationItem? _loadingToast;

  static void _showMessage({
    required String title,
    required String message,
    required ToastificationType type,
    IconData? icon,
  }) {
    _toastification.show(
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
    required String message,
    IconData? icon = Icons.check_circle,
  }) {
    _showMessage(title: title, message: message, type: ToastificationType.success, icon: icon);
  }

  static void showErrorMessage({
    String title = 'Error',
    required String message,
    IconData? icon = Icons.error,
  }) {
    _showMessage(title: title, message: message, type: ToastificationType.error, icon: icon);
  }

  /// Show a loading toast that stays visible until dismissed
  static void showLoadingToast({String title = 'Please Wait', required String message}) {
    // Dismiss any existing loading toast first
    dismissLoadingToast();

    _loadingToast = _toastification.show(
      title: Text(title),
      description: Text(message),
      style: ToastificationStyle.fillColored,
      autoCloseDuration: null, // Don't auto-close
      alignment: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 400),
      type: ToastificationType.info,
      icon: const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
      showIcon: true,
      showProgressBar: false,
      closeOnClick: false,
      pauseOnHover: false,
      applyBlurEffect: true,
    );
  }

  /// Dismiss the loading toast
  static void dismissLoadingToast() {
    if (_loadingToast != null) {
      _toastification.dismiss(_loadingToast!);
      _loadingToast = null;
    }
  }
}
