// lib/core/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:frontend/features/auth/signup/signup_screen.dart';
import 'package:frontend/features/auth/signup/signup_verification_screen.dart';
import 'package:frontend/features/onboarding/onboarding_screen.dart';
import 'package:frontend/features/splash/splash_screen.dart';

class Routes {
  Routes._();
  static const splash = '/splash';
  static const onBoarding = '/onboarding';
  static const signUp = '/signUp';
  static const signUpVerification = '/signupVerification';

  // Map of routes
  static final routes = <String, WidgetBuilder>{
    splash: (_) => const SplashScreen(),
    onBoarding: (_) => const OnboardingScreen(),
    signUp: (_) => const SignupScreen(),
    signUpVerification: (_) => const SignupVerificationScreen(),
  };
}
