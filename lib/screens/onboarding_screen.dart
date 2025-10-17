import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parkright/components/fade_slide_animation.dart';
import 'package:parkright/components/onboarding_title.dart';
import 'package:parkright/components/page_indicator.dart';
import 'package:parkright/components/pulse_animation.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/utils/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<String> _imagePaths = [
    'assets/svg/parking_map.svg',
    'assets/svg/booking.svg',
    'assets/svg/smart_parking.svg',
  ];
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }
  
  void _navigateToNextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: AppConstants.mediumAnimationDuration),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login screen to start the authentication flow
      Navigator.pushReplacementNamed(context, AppConstants.loginRoute);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(
                    image: _imagePaths[index],
                    title: AppConstants.onboardingTitles[index],
                    description: AppConstants.onboardingDescriptions[index],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip button
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
                    },
                    child: Text(
                      'Skip',
                      style: AppTextStyles.button.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  // Page indicator
                  PageIndicator(
                    pageCount: 3,
                    currentPage: _currentPage,
                  ),
                  // Next button with pulse animation
                  PulseAnimation(
                    isAnimating: _currentPage == 2, // Only animate on the last page
                    child: ElevatedButton(
                      onPressed: _navigateToNextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.buttonText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        _currentPage == 2 ? 'Get Started' : 'Next',
                        style: AppTextStyles.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOnboardingPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image with fade-in and slide animation
          FadeSlideAnimation(
            duration: const Duration(milliseconds: 600),
            verticalOffset: 30.0,
            child: SvgPicture.asset(
              image,
              height: 200,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 40),
          // Title with fade-in and slide animation
          FadeSlideAnimation(
            duration: const Duration(milliseconds: 800),
            verticalOffset: 30.0,
            delay: const Duration(milliseconds: 200),
            child: OnboardingTitle(
              title: title,
              description: description,
            ),
          ),
        ],
      ),
    );
  }
}