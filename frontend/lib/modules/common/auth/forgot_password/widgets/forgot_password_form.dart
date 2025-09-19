import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:get/get.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final AuthController _authController = Get.find<AuthController>();

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final result = await _authController.forgotPassword(_emailController.text);

    if (!result) {
      Toaster.showErrorMessage(message: _authController.error.value);
      return;
    }

    Toaster.showSuccessMessage(message: _authController.responseMessage.value);
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Get.toNamed(AuthRoutes.forgotPasswordVerification, arguments: _emailController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormTextField(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    controller: _emailController,
                    prefixIcon: FeatherIcons.mail,
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Email is required'),
                      EmailValidator(errorText: 'Enter a valid email'),
                      MinLengthValidator(6, errorText: 'At least 6 characters'),
                      MaxLengthValidator(254, errorText: 'At most 254 characters'),
                    ]).call,
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => PrimaryButton(
                      text: 'Submit',
                      onPressed: _handleSubmit,
                      isLoading: _authController.isLoading.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
