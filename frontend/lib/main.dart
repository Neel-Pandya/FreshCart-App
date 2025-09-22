import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/core/controllers/theme_controller.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/theme/app_theme.dart';
import 'package:frontend/core/controllers/bottom_nav_controller.dart';
import 'package:frontend/core/controllers/drawer_nav_controller.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final themeController = Get.put(ThemeController(), permanent: true);
  await themeController.isDarkModeEnabled();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController themeController = Get.put(ThemeController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: Obx(
        () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
          getPages: Routes.routes,
          initialRoute: Routes.splash,
          initialBinding: BindingsBuilder(() {
            Get.put(BottomNavController(), permanent: true);
            Get.put(DrawerNavController(), permanent: true);
            Get.put(AuthController(), permanent: true);
          }),
        ),
      ),
    );
  }
}
