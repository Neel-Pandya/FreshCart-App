// lib/core/routes/app_routes.dart
import 'package:get/get.dart';
import 'package:frontend/core/routes/admin_routes.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/routes/user_routes.dart';
import 'package:frontend/modules/common/onboarding/screens/onboarding_screen.dart';
import 'package:frontend/modules/common/splash/splash_screen.dart';

class Routes {
  Routes._();

  static const splash = '/splash';
  static const onBoarding = '/onboarding';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onBoarding, page: () => const OnboardingScreen()),
    ...AuthRoutes.routes,
    ...UserRoutes.routes,
    ...AdminRoutes.routes,
  ];
}
