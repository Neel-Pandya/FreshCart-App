import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  Rx<String?> selectedPaymentMethod = Rx<String?>(null);

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  String? getSelectedMethod() {
    return selectedPaymentMethod.value;
  }
}

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  late final PaymentMethodController paymentController;

  @override
  void initState() {
    super.initState();
    // Use the existing controller if already created, otherwise create new one
    if (Get.isRegistered<PaymentMethodController>()) {
      paymentController = Get.find<PaymentMethodController>();
    } else {
      paymentController = Get.put(PaymentMethodController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        onTap: () => _showModalBottomSheet(context),
        tileColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Get.theme.colorScheme.onSurface.withValues(alpha: 0.05),
        contentPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).brightness == Brightness.light
                ? const Color.fromRGBO(224, 224, 224, 1)
                : AppColors.borderDark,
            width: 1,
          ),
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            _getIconForPaymentMethod(paymentController.selectedPaymentMethod.value),
            color: Get.theme.colorScheme.onSurface,
          ),
        ),
        title: Text(
          paymentController.selectedPaymentMethod.value ?? 'RazorPay',
          style: AppTypography.titleMediumEmphasized.copyWith(
            color: Get.theme.colorScheme.onSurface,
          ),
        ),
        trailing: IconButton(
          icon: Icon(FeatherIcons.chevronRight, color: Get.theme.colorScheme.onSurface),
          onPressed: () => _showModalBottomSheet(context),
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      useSafeArea: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPaymentOptionTile(context, 'RazorPay', FeatherIcons.creditCard),
                const SizedBox(height: 10),
                _buildPaymentOptionTile(context, 'Cash on Delivery', FeatherIcons.truck),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentOptionTile(BuildContext context, String method, IconData icon) {
    return ListTile(
      tileColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Get.theme.colorScheme.onSurface.withValues(alpha: 0.05),
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Theme.of(context).brightness == Brightness.light
              ? const Color.fromRGBO(224, 224, 224, 1)
              : AppColors.borderDark,
          width: 1,
        ),
      ),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon, color: Get.theme.colorScheme.onSurface),
      ),
      title: Text(
        method,
        style: AppTypography.titleMediumEmphasized.copyWith(color: Get.theme.colorScheme.onSurface),
      ),
      onTap: () => _selectPaymentMethod(context, method),
    );
  }

  IconData _getIconForPaymentMethod(String? method) {
    switch (method) {
      case 'Cash on Delivery':
        return FeatherIcons.truck;
      case 'RazorPay':
      default:
        return FeatherIcons.creditCard;
    }
  }

  void _selectPaymentMethod(BuildContext context, String paymentMethod) {
    paymentController.selectPaymentMethod(paymentMethod);
    Get.back();
  }
}
