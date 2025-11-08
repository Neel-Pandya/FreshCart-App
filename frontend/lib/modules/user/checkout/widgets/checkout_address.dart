import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/modules/user/checkout/controller/checkout_address_controller.dart';
import 'package:get/get.dart';

class CheckoutAddress extends StatefulWidget {
  const CheckoutAddress({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<CheckoutAddress> createState() => _CheckoutAddressState();
}

class _CheckoutAddressState extends State<CheckoutAddress> {
  late final CheckoutAddressController addressController;

  @override
  void initState() {
    super.initState();
    // Use the existing controller if already created, otherwise create new one
    if (Get.isRegistered<CheckoutAddressController>()) {
      addressController = Get.find<CheckoutAddressController>();
    } else {
      addressController = Get.put(CheckoutAddressController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Address',
            style: AppTypography.titleMediumEmphasized.copyWith(
              color: Get.theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 15),
          FormTextField(
            controller: addressController.addressController,
            hintText: 'Enter your delivery address',
            prefixIcon: FeatherIcons.mapPin,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Address is required'),
              MinLengthValidator(10, errorText: 'At least 10 characters'),
            ]).call,
          ),
        ],
      ),
    );
  }
}
