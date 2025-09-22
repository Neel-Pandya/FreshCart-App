import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:frontend/core/controllers/bottom_nav_controller.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, this.onTap});
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavController>();
    return Obx(
      () => NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        onDestinationSelected: (index) {
          controller.setIndex(index);
          onTap?.call(index);
        },
        selectedIndex: controller.index.value,
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(FeatherIcons.home), label: 'Home'),
          NavigationDestination(icon: Icon(FeatherIcons.shoppingCart), label: 'Products'),
          NavigationDestination(icon: Icon(FeatherIcons.shoppingBag), label: 'Orders'),
          NavigationDestination(icon: Icon(FeatherIcons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
