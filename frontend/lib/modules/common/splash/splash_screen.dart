import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/layout/admin_master_layout.dart';
import 'package:frontend/layout/user_master_layout.dart';
import 'package:frontend/core/models/user.dart';
import 'package:get/get.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authController = Get.find<AuthController>();
  late final Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1500), () async {
      const storage = FlutterSecureStorage();
      final userKey = await storage.read(key: 'user');
      if (userKey == null) {
        Get.toNamed(Routes.onBoarding);
      } else {
        final user = User.fromJson(jsonDecode(userKey)['data']);
        _authController.user.value = user;
        Get.off(user.role == 1 ? const AdminMasterLayout() : const UserMasterLayout());
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Text(
            'FreshCart',
            style: AppTypography.headlineMediumEmphasized.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
