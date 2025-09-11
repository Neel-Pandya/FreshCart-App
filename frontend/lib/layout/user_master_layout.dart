import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/providers/bottom_nav_provider.dart';
import 'package:frontend/core/widgets/bottom_navigation.dart';
import 'package:frontend/features/home/home_screen.dart';
import 'package:frontend/features/products/products_screen.dart';
import 'package:frontend/features/orders/orders_screen.dart';
import 'package:frontend/features/settings/settings_screen.dart';

class UserMasterLayout extends ConsumerStatefulWidget {
  const UserMasterLayout({super.key});

  @override
  ConsumerState<UserMasterLayout> createState() => _UserMasterLayoutState();
}

class _UserMasterLayoutState extends ConsumerState<UserMasterLayout> {
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
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          ref.read(bottomNavigationProvider.notifier).state = index;
        },
        itemBuilder: (context, index) => screens[index],
        itemCount: screens.length,
      ),
      bottomNavigationBar: BottomNavigation(onTap: (index) => _pageController.jumpToPage(index)),
    );
  }
}
