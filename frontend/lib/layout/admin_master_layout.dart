import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/providers/drawer_nav_provider.dart';
import 'package:frontend/core/widgets/drawer_navigation.dart';
import 'package:frontend/features/admin/dashboard/dashboard_screen.dart';
import 'package:frontend/features/admin/products/screens/products_screen.dart';

class AdminMasterLayout extends ConsumerStatefulWidget {
  const AdminMasterLayout({super.key});

  @override
  ConsumerState<AdminMasterLayout> createState() => _AdminMasterLayoutState();
}

class _AdminMasterLayoutState extends ConsumerState<AdminMasterLayout> {
  final List<Map<String, dynamic>> _screens = const [
    {'title': 'Dashboard', 'widget': DashboardScreen()},
    {'title': 'Products', 'widget': ProductsScreen()},
    {'title': 'Orders', 'widget': Placeholder()},
    {'title': 'Categories', 'widget': Placeholder()},
    {'title': 'Users', 'widget': Placeholder()},
    {'title': 'Settings', 'widget': Placeholder()},
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(drawerNavigationProvider);

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
  }
}
