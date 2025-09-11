import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/providers/drawer_nav_provider.dart';
import 'package:frontend/core/widgets/drawer_navigation.dart';
import 'package:frontend/features/admin/Dashboard/dashboard_screen.dart';

class AdminMasterLayout extends ConsumerStatefulWidget {
  const AdminMasterLayout({super.key});

  @override
  ConsumerState<AdminMasterLayout> createState() => _AdminMasterLayoutState();
}

class _AdminMasterLayoutState extends ConsumerState<AdminMasterLayout> {
  final List<Map<String, dynamic>> _screens = const [
    {'title': 'Dashboard', 'widget': DashboardScreen()},
    {'title': 'Products', 'widget': Placeholder()},
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
      appBar: AppBar(title: Text(_screens[selectedIndex]['title'])),
    );
  }
}
