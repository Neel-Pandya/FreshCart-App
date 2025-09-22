import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/drawer_navigation.dart';
import 'package:frontend/modules/admin/category/screens/category_screen.dart';
import 'package:frontend/modules/admin/dashboard/screens/dashboard_screen.dart';
import 'package:frontend/modules/admin/product/screens/products_screen.dart';
import 'package:frontend/modules/admin/user/screens/user_screen.dart';
import 'package:frontend/modules/admin/settings/screens/settings_screen.dart';
import 'package:frontend/modules/admin/orders/screens/orders_screen.dart';
import 'package:get/get.dart';
import 'package:frontend/core/controllers/drawer_nav_controller.dart';

class AdminMasterLayout extends StatefulWidget {
  const AdminMasterLayout({super.key});

  @override
  State<AdminMasterLayout> createState() => _AdminMasterLayoutState();
}

class _AdminMasterLayoutState extends State<AdminMasterLayout> {
  final List<Map<String, dynamic>> _screens = [
    {'title': 'Dashboard', 'widget': const DashboardScreen()},
    {'title': 'Products', 'widget': const ProductsScreen()},
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
              child: Image.asset('assets/images/user/common_profile.png', height: 48, width: 48),
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      );
    });
  }
}
