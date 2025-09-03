// lib/core/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:frontend/features/onboarding/onboarding_screen.dart';
import 'package:frontend/features/splash/splash_screen.dart';

class Routes {
  Routes._();
  static const splash = '/splash';
  static const onBoarding = '/onboarding';
  static const demo = '/demo';

  // Map of routes
  static final routes = <String, WidgetBuilder>{
    splash: (_) => const SplashScreen(),
    onBoarding: (_) => const OnboardingScreen(),
    demo: (_) => const OnboardingScreen(),
  };
}
