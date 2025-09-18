import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/bottom_navigation.dart';
import 'package:frontend/modules/user/home/screens/home_screen.dart';
import 'package:frontend/modules/user/products/screens/products_screen.dart';
import 'package:frontend/modules/user/orders/screens/orders_screen.dart';
import 'package:frontend/modules/user/settings/screens/settings_screen.dart';
import 'package:get/get.dart';
import 'package:frontend/core/controllers/bottom_nav_controller.dart';

class UserMasterLayout extends StatefulWidget {
  const UserMasterLayout({super.key});

  @override
  State<UserMasterLayout> createState() => _UserMasterLayoutState();
}

class _UserMasterLayoutState extends State<UserMasterLayout> {
  late final PageController _pageController;
  final screens = [
    const HomeScreen(),
    const ProductsScreen(),
    const OrdersScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<BottomNavController>();
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          nav.setIndex(index);
        },
        itemBuilder: (context, index) => screens[index],
        itemCount: screens.length,
      ),
      bottomNavigationBar: BottomNavigation(onTap: (index) => _pageController.jumpToPage(index)),
    );
  }
}
