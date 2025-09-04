import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/validators/confirm_password_validator.dart';
import 'package:frontend/core/widgets/filled_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/utils/toaster.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    Toaster.showSuccessMessage(context: context, message: 'Password Reset successful');

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacementNamed(AuthRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledTextfield(
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: FeatherIcons.lock,
            suffixIcon: _isPasswordVisible ? FeatherIcons.eye : FeatherIcons.eyeOff,
            obscureText: !_isPasswordVisible,
            controller: _passwordController,
            onSuffixTap: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            validator: MultiValidator([
              RequiredValidator(errorText: 'Password is required'),
              MinLengthValidator(8, errorText: 'At least 8 characters'),
              MaxLengthValidator(50, errorText: 'At most 50 characters'),
              PatternValidator(
                r'^(?=.*[A-Z]).+$',
                errorText: 'Must contain at least one uppercase letter',
              ),

              PatternValidator(
                r'^(?=.*[a-z]).+$',
                errorText: 'Must contain at least one lowercase letter',
              ),

              PatternValidator(r'^(?=.*\d).+$', errorText: 'Must contain at least one number'),

              PatternValidator(
                r'^(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]).+$',
                errorText: 'Must contain at least one special character',
              ),
            ]).call,
          ),
          const SizedBox(height: 20),
          FilledTextfield(
            labelText: 'Confirm Password',
            hintText: 'Enter your confirm password',
            prefixIcon: FeatherIcons.lock,
            suffixIcon: _isConfirmPasswordVisible ? FeatherIcons.eye : FeatherIcons.eyeOff,
            obscureText: !_isConfirmPasswordVisible,
            controller: _confirmPasswordController,
            onSuffixTap: () =>
                setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
            validator: MultiValidator([
              RequiredValidator(errorText: 'Confirm Password is required'),
              MinLengthValidator(8, errorText: 'At least 8 characters'),
              MaxLengthValidator(50, errorText: 'At most 50 characters'),
              PatternValidator(
                r'^(?=.*[A-Z]).+$',
                errorText: 'Must contain at least one uppercase letter',
              ),

              PatternValidator(
                r'^(?=.*[a-z]).+$',
                errorText: 'Must contain at least one lowercase letter',
              ),

              PatternValidator(r'^(?=.*\d).+$', errorText: 'Must contain at least one number'),

              PatternValidator(
                r'^(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]).+$',
                errorText: 'Must contain at least one special character',
              ),

              ConfirmPasswordValidator(getPassword: () => _passwordController.text),
            ]).call,
          ),
          const SizedBox(height: 20),
          PrimaryButton(text: 'Submit', onPressed: _handleSubmit),
        ],
      ),
    );
  }
}
