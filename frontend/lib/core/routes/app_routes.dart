// lib/core/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/routes/user_routes.dart';
import 'package:frontend/features/onboarding/onboarding_screen.dart';
import 'package:frontend/features/splash/splash_screen.dart';

class Routes {
  Routes._();
  static const splash = '/splash';
  static const onBoarding = '/onboarding';

  // Map of routes
  static final routes = <String, WidgetBuilder>{
    splash: (_) => const SplashScreen(),
    onBoarding: (_) => const OnboardingScreen(),
    ...AuthRoutes.routes,
    ...UserRoutes.routes,
  };
}
