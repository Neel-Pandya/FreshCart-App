import 'package:flutter/material.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/utils/toaster.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordVerificationScreen extends StatefulWidget {
  const ForgotPasswordVerificationScreen({super.key});

  @override
  State<ForgotPasswordVerificationScreen> createState() => _ForgotPasswordVerificationScreenState();
}

class _ForgotPasswordVerificationScreenState extends State<ForgotPasswordVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  void _onSubmit(BuildContext context) {
    final otp = _otpController.text.trim();

    if (otp.isEmpty) {
      Toaster.showErrorMessage(message: "Please enter OTP", context: context);
      return;
    }
    if (otp.length < 6) {
      Toaster.showErrorMessage(message: "Enter all 6 digits", context: context);
      return;
    }

    Toaster.showSuccessMessage(message: "OTP Submitted: $otp", context: context);

    Navigator.of(context).pushReplacementNamed(AuthRoutes.resetPassword);
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
          style: AppTypography.titleLarge.copyWith(color: AppColors.textPrimary),
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
                // ✅ Icon
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
                  style: AppTypography.titleMediumEmphasized.copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 5),
                Text(
                  'We have sent the code verification to',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 5),
                Text(
                  'neelpandya2601@gmail.com',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
                ),

                const SizedBox(height: 22),

                // ✅ OTP Input
                PinCodeTextField(
                  appContext: context,
                  controller: _otpController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  enableActiveFill: true,
                  autoDisposeControllers: false,
                  textStyle: AppTypography.titleMediumEmphasized.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 55,
                    fieldWidth: 45,
                    borderWidth: 1,
                    activeColor: AppColors.primary,
                    inactiveColor: const Color(0xffCAC4D0),
                    selectedColor: AppColors.primary,
                    errorBorderColor: AppColors.error,
                    activeFillColor: AppColors.background,
                    inactiveFillColor: AppColors.background,
                    selectedFillColor: AppColors.background,
                  ),
                  onChanged: (_) {},
                ),

                const SizedBox(height: 12),

                // ✅ Submit Button
                PrimaryButton(text: 'Submit', onPressed: () => _onSubmit(context)),

                const SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't receive the code ? "),
                    Text(
                      'Resend',
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
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
