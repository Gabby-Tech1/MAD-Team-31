import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkright/screens/home_screen.dart';
import 'package:parkright/screens/onboarding_screen.dart';
import 'package:parkright/screens/splash_screen.dart';
import 'package:parkright/utils/app_constants.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.splashRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const SplashScreen(),
          duration: const Duration(milliseconds: AppConstants.shortAnimationDuration),
        );
        
      case AppConstants.onboardingRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const OnboardingScreen(),
          duration: const Duration(milliseconds: AppConstants.shortAnimationDuration),
        );
        
      case AppConstants.homeRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const HomeScreen(),
          duration: const Duration(milliseconds: AppConstants.shortAnimationDuration),
        );
        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}