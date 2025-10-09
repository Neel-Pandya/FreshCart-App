import 'package:flutter/material.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

class ForgotPasswordVerificationScreen extends StatefulWidget {
  const ForgotPasswordVerificationScreen({super.key});

  @override
  State<ForgotPasswordVerificationScreen> createState() => _ForgotPasswordVerificationScreenState();
}

class _ForgotPasswordVerificationScreenState extends State<ForgotPasswordVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final _email = Get.arguments as String;

  final AuthController _authController = Get.find<AuthController>();

  void _onSubmit(BuildContext context) async {
    final otp = _otpController.text.trim();

    if (otp.isEmpty) {
      Toaster.showErrorMessage(message: 'Please enter OTP');
      return;
    }
    if (otp.length < 6) {
      Toaster.showErrorMessage(message: 'Enter all 6 digits');
      return;
    }

    final result = await _authController.verifyOtp(_email, otp);
    if (!result) {
      Toaster.showErrorMessage(message: _authController.error.value);
      return;
    }

    Toaster.showSuccessMessage(message: _authController.responseMessage.value);
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Get.offNamed(AuthRoutes.resetPassword, arguments: _email);
    });
  }

  void _handleResendOtp() async {
    final result = await _authController.resendOtp(_email);
    if (!result) {
      Toaster.showErrorMessage(message: _authController.error.value);
      return;
    }

    Toaster.showSuccessMessage(message: _authController.responseMessage.value);
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
          style: AppTypography.titleLarge.copyWith(color: Get.theme.colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // âœ… Icon
                Center(
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.mail, size: 30, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 12),
                Text(
                  'Verification Code',
                  textAlign: TextAlign.center,
                  style: AppTypography.titleMediumEmphasized.copyWith(
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'We have sent the code verification to',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(
                    color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _email,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(
                    color: Get.theme.colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 22),

                // âœ… OTP Input
                PinCodeTextField(
                  appContext: context,
                  controller: _otpController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  enableActiveFill: true,
                  autoDisposeControllers: false,
                  textStyle: AppTypography.titleMediumEmphasized.copyWith(
                    color: Get.theme.colorScheme.onSurface,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 55,
                    fieldWidth: 45,
                    borderWidth: 1,
                    activeColor: Get.theme.colorScheme.primary,
                    inactiveColor: Get.theme.brightness == Brightness.dark
                        ? AppColors.borderDark
                        : AppColors.border,
                    selectedColor: Get.theme.colorScheme.primary,
                    errorBorderColor: Get.theme.colorScheme.error,
                    activeFillColor: Get.theme.colorScheme.surfaceContainerHighest,
                    inactiveFillColor: Get.theme.colorScheme.surfaceContainerHighest,
                    selectedFillColor: Get.theme.colorScheme.surfaceContainerHighest,
                  ),
                  cursorColor: Get.theme.brightness == Brightness.dark
                      ? Get.theme.colorScheme.onSurface
                      : Get.theme.colorScheme.onSurface,
                  onChanged: (_) {},
                ),

                const SizedBox(height: 12),

                // âœ… Submit Button
                Obx(
                  () => PrimaryButton(
                    text: 'Submit',
                    onPressed: () => _onSubmit(context),
                    isLoading: _authController.isLoading.value,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't receive the code ? "),
                    GestureDetector(
                      onTap: _handleResendOtp,
                      child: Text(
                        'Resend',
                        style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
