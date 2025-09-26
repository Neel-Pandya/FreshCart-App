import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:frontend/core/controllers/drawer_nav_controller.dart';
import 'package:frontend/core/theme/app_typography.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final labelStyle = AppTypography.labelLargeEmphasized;
    final controller = Get.find<DrawerNavController>();
    return Obx(() => NavigationDrawer(
          onDestinationSelected: (index) {
            controller.setIndex(index);
            Get.back();
          },

          selectedIndex: controller.index.value,

          children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: GestureDetector(
            onTap: () {
              Get.back();
              controller.setIndex(5);
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/user/common_profile.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Text('Neel Pandya', style: labelStyle),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),
        NavigationDrawerDestination(
          icon: const Icon(FeatherIcons.home),
          label: Text('Home', style: labelStyle),
          selectedIcon: const Icon(FeatherIcons.home),
        ),
        NavigationDrawerDestination(
          icon: const Icon(FeatherIcons.shoppingCart),
          label: Text('Products', style: labelStyle),
          selectedIcon: const Icon(FeatherIcons.shoppingCart),
        ),
        NavigationDrawerDestination(
          icon: const Icon(FeatherIcons.shoppingBag),
          label: Text('Orders', style: labelStyle),
          selectedIcon: const Icon(FeatherIcons.shoppingBag),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.category_outlined),
          label: Text('Categories', style: labelStyle),
          selectedIcon: const Icon(Icons.category_outlined),
        ),
        NavigationDrawerDestination(
          icon: const Icon(FeatherIcons.users),
          label: Text('Users', style: labelStyle),
          selectedIcon: const Icon(FeatherIcons.users),
        ),
        NavigationDrawerDestination(
          icon: const Icon(FeatherIcons.settings),
          label: Text('Settings', style: labelStyle),
          selectedIcon: const Icon(FeatherIcons.settings),
        ),
      ],
        ));
  }
}
