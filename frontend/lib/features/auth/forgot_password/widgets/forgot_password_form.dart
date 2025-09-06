import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/widgets/filled_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/utils/toaster.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    Toaster.showSuccessMessage(context: context, message: 'Password reset link sent');

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.of(context).pushNamed(AuthRoutes.forgotPasswordVerification);
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
                  FilledTextfield(
                    labelText: 'Email',
                    hintText: 'Enter your email',
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
                  PrimaryButton(text: 'Submit', onPressed: _handleSubmit),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
