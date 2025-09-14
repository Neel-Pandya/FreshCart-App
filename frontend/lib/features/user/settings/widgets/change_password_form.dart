import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/validators/confirm_password_validator.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  var _isOldPasswordVisible = false;
  var _isNewPasswordVisible = false;
  var _isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleChangePassword() {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    Toaster.showSuccessMessage(context: context, message: 'Password changed successfully');

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(Routes.onBoarding, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormTextField(
            labelText: 'Old Password',
            hintText: 'Enter your old password',
            prefixIcon: FeatherIcons.lock,
            obscureText: !_isOldPasswordVisible,
            suffixIcon: _isOldPasswordVisible ? FeatherIcons.eye : FeatherIcons.eyeOff,
            onSuffixTap: () => setState(() => _isOldPasswordVisible = !_isOldPasswordVisible),
            controller: _oldPasswordController,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Old Password is required'),
              MinLengthValidator(8, errorText: 'At least 8 characters'),
              MaxLengthValidator(50, errorText: 'At most 50 characters'),
            ]).call,
          ),

          const SizedBox(height: 15),

          FormTextField(
            labelText: 'New Password',
            hintText: 'Enter your new password',
            prefixIcon: FeatherIcons.lock,
            obscureText: !_isNewPasswordVisible,
            suffixIcon: _isNewPasswordVisible ? FeatherIcons.eye : FeatherIcons.eyeOff,
            onSuffixTap: () => setState(() => _isNewPasswordVisible = !_isNewPasswordVisible),
            controller: _newPasswordController,
            validator: MultiValidator([
              RequiredValidator(errorText: 'New Password is required'),
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

          const SizedBox(height: 15),

          FormTextField(
            labelText: 'Confirm Password',
            hintText: 'Confirm New Password',
            prefixIcon: FeatherIcons.lock,
            obscureText: !_isConfirmPasswordVisible,
            suffixIcon: _isConfirmPasswordVisible ? FeatherIcons.eye : FeatherIcons.eyeOff,
            onSuffixTap: () =>
                setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
            controller: _confirmPasswordController,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Confirm Password is required'),
              MinLengthValidator(8, errorText: 'At least 8 characters'),
              MaxLengthValidator(50, errorText: 'At most 50 characters'),
              ConfirmPasswordValidator(getPassword: () => _newPasswordController.text),
            ]).call,
          ),

          const SizedBox(height: 30),

          PrimaryButton(text: 'Change Password', onPressed: _handleChangePassword),
        ],
      ),
    );
  }
}
