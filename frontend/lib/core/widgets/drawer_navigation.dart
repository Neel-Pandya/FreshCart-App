import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/providers/drawer_nav_provider.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';

class DrawerNavigation extends ConsumerWidget {
  const DrawerNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labelStyle = AppTypography.labelLargeEmphasized;
    final selectedIndex = ref.watch(drawerNavigationProvider);
    return NavigationDrawer(
      onDestinationSelected: (index) {
        ref.read(drawerNavigationProvider.notifier).state = index;
        Navigator.of(context).pop();
      },

      selectedIndex: selectedIndex,

      children: [
        NavigationDrawerDestination(
          icon: const Icon(FeatherIcons.home, color: AppColors.iconColor),
          label: Text('Home', style: labelStyle),
          selectedIcon: const Icon(FeatherIcons.home),
        ),
        NavigationDrawerDestination(
          icon: const Icon(FeatherIcons.shoppingCart, color: AppColors.iconColor),
          label: Text('Products', style: labelStyle),
          selectedIcon: const Icon(FeatherIcons.shoppingCart),
        ),
        NavigationDrawerDestination(
          icon: const Icon(FeatherIcons.shoppingBag, color: AppColors.iconColor),
          label: Text('Orders', style: labelStyle),
          selectedIcon: const Icon(FeatherIcons.shoppingBag),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.category_outlined, color: AppColors.iconColor),
          label: Text('Categories', style: labelStyle),
          selectedIcon: const Icon(Icons.category_outlined),
        ),
        NavigationDrawerDestination(
          icon: const Icon(FeatherIcons.users, color: AppColors.iconColor),
          label: Text('Users', style: labelStyle),
          selectedIcon: const Icon(FeatherIcons.users),
        ),
        NavigationDrawerDestination(
          icon: const Icon(FeatherIcons.settings, color: AppColors.iconColor),
          label: Text('Settings', style: labelStyle),
          selectedIcon: const Icon(FeatherIcons.settings),
        ),
      ],
    );
  }
}
