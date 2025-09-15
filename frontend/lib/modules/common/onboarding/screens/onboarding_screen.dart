import 'package:flutter/material.dart';
import 'package:frontend/core/routes/auth_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/app_typography.dart';
import 'package:frontend/core/widgets/primary_button.dart';
import 'package:frontend/modules/common/onboarding/data/onboarding_data.dart';
import 'package:frontend/modules/common/onboarding/widgets/onboarding_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  constraints: const BoxConstraints(minHeight: 446, maxHeight: 480),
                  child: _pageView(),
                ),
                _pageIndicator(),
                const SizedBox(height: 25),
                _authOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _authOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimaryButton(
          text: 'Create Account',
          onPressed: () => Navigator.of(context).pushNamed(AuthRoutes.signUp),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(AuthRoutes.login),
          child: Text(
            'Already Have An Account',
            textAlign: TextAlign.center,
            style: AppTypography.titleSmall.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  // page view
  PageView _pageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: onBoardingData.length,
      itemBuilder: (context, index) => OnboardingItem(item: onBoardingData[index]),
    );
  }

  // Smooth Page Indicator
  Widget _pageIndicator() {
    return Center(
      child: SmoothPageIndicator(
        controller: _pageController,
        count: onBoardingData.length,
        effect: const JumpingDotEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: AppColors.primary,
          dotColor: AppColors.border,
        ),

        onDotClicked: (page) => _pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
