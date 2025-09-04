import 'package:flutter/material.dart';
import 'package:frontend/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:frontend/features/auth/forgot_password/forgot_password_verification_screen.dart';
import 'package:frontend/features/auth/login/login_screen.dart';
import 'package:frontend/features/auth/signup/signup_screen.dart';
import 'package:frontend/features/auth/signup/signup_verification_screen.dart';
import 'package:frontend/features/auth/forgot_password/reset_password_screen.dart';

class AuthRoutes {
  static const login = '/login';
  static const forgotPassword = '/forgotPassword';
  static const forgotPasswordVerification = '/forgotPasswordVerification';
  static const signUp = '/signUp';
  static const signUpVerification = '/signupVerification';
  static const resetPassword = '/resetPassword';

  static final routes = <String, WidgetBuilder>{
    login: (_) => const LoginScreen(),
    forgotPassword: (_) => const ForgotPasswordScreen(),
    forgotPasswordVerification: (_) => const ForgotPasswordVerificationScreen(),
    signUp: (_) => const SignupScreen(),
    signUpVerification: (_) => const SignupVerificationScreen(),
    resetPassword: (_) => const ResetPasswordScreen(),
  };
}
