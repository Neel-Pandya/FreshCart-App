import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/core/widgets/secondary_button.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  void _handleCreateAccount() {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    Toaster.showSuccessMessage(context: context, message: 'Account created');

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.of(context).pushNamed(AuthRoutes.signUpVerification);
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
            prefixIcon: FeatherIcons.user,
            hintText: 'Enter your name',
            labelText: 'Name',
            keyboardType: TextInputType.name,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Name is required'),
              MinLengthValidator(2, errorText: 'At least 2 characters'),
              MaxLengthValidator(50, errorText: 'At most 50 characters'),
              PatternValidator(
                r'^[a-zA-Z\s]+$',
                errorText: 'Name can only contain letters and spaces',
              ),
            ]).call,
          ),
          const SizedBox(height: 20),

          FormTextField(
            prefixIcon: FeatherIcons.mail,
            hintText: 'Enter your email',
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Email is required'),
              EmailValidator(errorText: 'Enter a valid email'),
              MinLengthValidator(6, errorText: 'At least 6 characters'),
              MaxLengthValidator(254, errorText: 'At most 254 characters'),
            ]).call,
          ),
          const SizedBox(height: 20),

          FormTextField(
            prefixIcon: FeatherIcons.lock,
            hintText: 'Enter your password',
            labelText: 'Password',
            obscureText: _obscurePassword,
            suffixIcon: _obscurePassword ? FeatherIcons.eye : FeatherIcons.eyeOff,
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
            onSuffixTap: () => setState(() => _obscurePassword = !_obscurePassword),
          ),

          const SizedBox(height: 20),

          PrimaryButton(text: 'Create Account', onPressed: _handleCreateAccount),

          const SizedBox(height: 10),

          Text(
            'OR',
            textAlign: TextAlign.center,
            style: AppTypography.labelLarge.copyWith(color: AppColors.textMuted),
          ),

          SecondaryButton(
            text: 'Sign Up with Google',
            icon: SvgPicture.asset('assets/icons/google_icon.svg', width: 20, height: 20),
          ),
        ],
      ),
    );
  }
}
