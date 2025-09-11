import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/routes/user_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/filled_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/core/widgets/secondary_button.dart';
import 'package:frontend/core/utils/toaster.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    Toaster.showSuccessMessage(context: context, message: 'Login successful');

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.of(context).pushNamed(UserRoutes.master);
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
          FilledTextfield(
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: FeatherIcons.lock,
            suffixIcon: _isPasswordVisible ? FeatherIcons.eye : FeatherIcons.eyeOff,
            onSuffixTap: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            obscureText: !_isPasswordVisible,
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
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AuthRoutes.forgotPassword),
            child: Text(
              'Forgot Password ?',
              textAlign: TextAlign.end,
              style: AppTypography.bodyMedium.copyWith(color: AppColors.success),
            ),
          ),
          const SizedBox(height: 20),
          PrimaryButton(text: 'Sign In', onPressed: _handleLogin),
          const SizedBox(height: 10),
          Text(
            'OR',
            textAlign: TextAlign.center,
            style: AppTypography.labelLarge.copyWith(color: AppColors.textMuted),
          ),
          SecondaryButton(
            text: 'Sign In with Google',
            icon: SvgPicture.asset('assets/icons/google_icon.svg', width: 20, height: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
