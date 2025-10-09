import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/drawer_navigation.dart';
import 'package:frontend/modules/admin/category/screens/category_screen.dart';
import 'package:frontend/modules/admin/dashboard/screens/dashboard_screen.dart';
import 'package:frontend/modules/admin/product/screens/products_screen.dart';
import 'package:frontend/modules/admin/user/screens/user_screen.dart';
import 'package:frontend/modules/admin/user/controller/user_controller.dart';
import 'package:frontend/modules/admin/product/controller/product_controller.dart';
import 'package:frontend/modules/admin/category/controllers/category_controller.dart';
import 'package:frontend/modules/common/auth/common/controllers/auth_controller.dart';
import 'package:frontend/modules/common/settings/screens/settings_screen.dart';
import 'package:frontend/modules/admin/orders/screens/orders_screen.dart';
import 'package:get/get.dart';
import 'package:frontend/core/controllers/drawer_nav_controller.dart';

class AdminMasterLayout extends StatefulWidget {
  const AdminMasterLayout({super.key});

  @override
  State<AdminMasterLayout> createState() => _AdminMasterLayoutState();
}

class _AdminMasterLayoutState extends State<AdminMasterLayout> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // Initialize admin controllers
    Get.put(ProductController(), permanent: true);
    Get.put(CategoryController(), permanent: true);
    Get.put(UserController(), permanent: true);
  }

  final List<Map<String, dynamic>> _screens = [
    {'title': 'Dashboard', 'widget': DashboardScreen()},
    {'title': 'Products', 'widget': ProductsScreen()},
    {'title': 'Orders', 'widget': const OrdersScreen()},
    {'title': 'Categories', 'widget': const CategoryScreen()},
    {'title': 'Users', 'widget': const UserScreen()},
    {'title': 'Settings', 'widget': SettingsScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DrawerNavController>();

    return Obx(() {
      final selectedIndex = controller.index.value;
      return Scaffold(
        body: _screens[selectedIndex]['widget'],
        drawer: const DrawerNavigation(),
        appBar: AppBar(
          title: Text(_screens[selectedIndex]['title']),
          actions: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Obx(
                () => Image.network(
                  _authController.user.value?.imageUrl ?? '',
                  height: 48,
                  width: 48,
                ),
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      );
    });
  }
}
