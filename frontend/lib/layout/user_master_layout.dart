import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/providers/bottom_nav_provider.dart';
import 'package:frontend/core/widgets/bottom_navigation.dart';
import 'package:frontend/features/home/home_screen.dart';

class UserMasterLayout extends ConsumerWidget {
  UserMasterLayout({super.key});

  final screens = [
    const HomeScreen(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationProvider);
    return Scaffold(body: screens[currentIndex], bottomNavigationBar: const BottomNavigation());
  }
}
