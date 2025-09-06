import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/providers/bottom_nav_provider.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({super.key, this.onTap});
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationProvider);
    return NavigationBar(
      backgroundColor: Colors.white,
      onDestinationSelected: (index) {
        onTap?.call(index);
      },
      selectedIndex: currentIndex,
      destinations: const <NavigationDestination>[
        NavigationDestination(icon: Icon(FeatherIcons.home), label: 'Home'),
        NavigationDestination(icon: Icon(FeatherIcons.shoppingCart), label: 'Products'),
        NavigationDestination(icon: Icon(FeatherIcons.shoppingBag), label: 'Orders'),
        NavigationDestination(icon: Icon(FeatherIcons.settings), label: 'Settings'),
      ],
    );
  }
}
