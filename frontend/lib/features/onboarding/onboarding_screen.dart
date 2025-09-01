import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Column(children: [Text('Hello World')])),
    );
  }
}
