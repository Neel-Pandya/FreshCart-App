import 'package:get/get.dart';
import 'package:frontend/modules/common/auth/forgot_password/screens/forgot_password_screen.dart';
import 'package:frontend/modules/common/auth/forgot_password/screens/forgot_password_verification_screen.dart';
import 'package:frontend/modules/common/auth/login/screens/login_screen.dart';
import 'package:frontend/modules/common/auth/signup/screens/signup_screen.dart';
import 'package:frontend/modules/common/auth/signup/screens/signup_verification_screen.dart';
import 'package:frontend/modules/common/auth/forgot_password/screens/reset_password_screen.dart';

class AuthRoutes {
  static const login = '/login';
  static const forgotPassword = '/forgotPassword';
  static const forgotPasswordVerification = '/forgotPasswordVerification';
  static const signUp = '/signUp';
  static const signUpVerification = '/signupVerification';
  static const resetPassword = '/resetPassword';

  static final routes = [
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: forgotPasswordVerification, page: () => const ForgotPasswordVerificationScreen()),
    GetPage(name: signUp, page: () => const SignupScreen()),
    GetPage(name: signUpVerification, page: () => const SignupVerificationScreen()),
    GetPage(name: resetPassword, page: () => const ResetPasswordScreen()),
  ];
}
