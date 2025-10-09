import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/core/widgets/secondary_button.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:frontend/modules/common/auth/login/screens/login_screen.dart';
import 'package:get/get.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  late final AuthController _authController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleCreateAccount() async {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final result = await _authController.signup(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!result) {
      Toaster.showErrorMessage(message: _authController.error.value);
      return;
    }

    Toaster.showSuccessMessage(message: _authController.responseMessage.value);

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Get.toNamed(AuthRoutes.signUpVerification, arguments: _emailController.text);
    });
  }

  void _handleGoogleSignup() async {
    final result = await _authController.googleSignup();
    if (!result) {
      Toaster.showErrorMessage(message: _authController.error.value);
      return;
    }

    Toaster.showSuccessMessage(message: _authController.responseMessage.value);

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Get.to(const LoginScreen());
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
            controller: _nameController,
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
            controller: _emailController,
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
            controller: _passwordController,
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

          Obx(
            () => PrimaryButton(
              text: 'Create Account',
              onPressed: _handleCreateAccount,
              isLoading: _authController.isLoading.value,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'OR',
            textAlign: TextAlign.center,
            style: AppTypography.labelLarge.copyWith(
              color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),

          const SizedBox(height: 10),
          SecondaryButton(
            text: 'Sign Up with Google',
            icon: SvgPicture.asset('assets/icons/google_icon.svg', width: 20, height: 20),
            onPressed: _handleGoogleSignup,
          ),
        ],
      ),
    );
  }
}
