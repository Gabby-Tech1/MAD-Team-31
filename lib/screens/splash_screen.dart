import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/utils/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppConstants.mediumAnimationDuration * 2),
    );
    
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    
    // Start the animation
    _controller.forward();
    
    // Navigate to onboarding screen after delay
    Future.delayed(const Duration(milliseconds: AppConstants.splashDuration), () {
      Navigator.pushReplacementNamed(context, AppConstants.onboardingRoute);
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with scale and opacity animation
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/svg/logo.svg',
                height: 120,
                width: 120,
              ),
            ),
            const SizedBox(height: 24),
            // App name with fade in animation
            FadeTransition(
              opacity: _opacityAnimation,
              child: Text(
                AppConstants.appName,
                style: AppTextStyles.headline1,
              ),
            ),
            const SizedBox(height: 8),
            // Animated typing text for slogan
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    AppConstants.appSlogan,
                    textStyle: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: false,
                totalRepeatCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}