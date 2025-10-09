import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:get/get.dart';

class CheckoutAddress extends StatefulWidget {
  const CheckoutAddress({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<CheckoutAddress> createState() => _CheckoutAddressState();
}

class _CheckoutAddressState extends State<CheckoutAddress> {
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Address',
            style: AppTypography.titleMediumEmphasized.copyWith(
              color: Get.theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 15),
          FormTextField(
            controller: _addressController,
            hintText: 'Enter your address',
            prefixIcon: FeatherIcons.mapPin,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Address is required'),
              MinLengthValidator(10, errorText: 'At least 10 characters'),
              MaxLengthValidator(255, errorText: 'At most 255 characters'),
              PatternValidator(
                r'^[a-zA-Z0-9\s,./-]*$',
                errorText:
                    'Address can only contain letters, numbers, spaces, commas, periods, and hyphens',
              ),
            ]).call,
          ),
        ],
      ),
    );
  }
}
