import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showModalBottomSheet(context),
      tileColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.border, width: 1),
      ),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          _getIconForPaymentMethod(selectedPaymentMethod),
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      title: Text(
        selectedPaymentMethod ?? 'RazorPay',
        style: AppTypography.titleMediumEmphasized.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: IconButton(
        icon: Icon(FeatherIcons.chevronRight, color: Theme.of(context).colorScheme.onSurface),
        onPressed: () => _showModalBottomSheet(context),
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
      tileColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 1),
      ),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      ),
      title: Text(
        method,
        style: AppTypography.titleMediumEmphasized.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
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
    setState(() {
      selectedPaymentMethod = paymentMethod;
    });
    Get.back();
  }
}
