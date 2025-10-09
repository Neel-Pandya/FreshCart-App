import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/widgets/form_textfield.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/core/widgets/secondary_button.dart';
import 'package:frontend/layout/admin_master_layout.dart';
import 'package:frontend/layout/user_master_layout.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final AuthController _authController = Get.find<AuthController>();

  void _handleGoogleLogin() async {
    final result = await _authController.googleLogin();
    if (!result) {
      Toaster.showErrorMessage(message: _authController.error.value);
      return;
    }
    Toaster.showSuccessMessage(message: _authController.responseMessage.value);
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(const UserMasterLayout());
    });
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final result = await _authController.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!result) {
      Toaster.showErrorMessage(message: _authController.error.value);
      return;
    }

    Toaster.showSuccessMessage(message: _authController.responseMessage.value);
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(
        _authController.user.value!.role == 1
            ? const AdminMasterLayout()
            : const UserMasterLayout(),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormTextField(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: FeatherIcons.mail,
              controller: _emailController,
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
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: FeatherIcons.lock,
              controller: _passwordController,
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
              onTap: () => Get.toNamed(AuthRoutes.forgotPassword),
              child: Text(
                'Forgot Password ?',
                textAlign: TextAlign.end,
                style: AppTypography.bodyMedium.copyWith(color: AppColors.success),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: 'Sign In',
              onPressed: _handleLogin,
              isLoading: _authController.isLoading.value,
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
              text: 'Sign In with Google',
              icon: SvgPicture.asset('assets/icons/google_icon.svg', width: 20, height: 20),
              onPressed: _handleGoogleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
