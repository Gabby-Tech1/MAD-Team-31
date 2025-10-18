import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parkright/screens/add_vehicle_screen.dart';
import 'package:parkright/screens/login_screen.dart';
import 'package:parkright/screens/onboarding_screen.dart';
import 'package:parkright/screens/register_screen.dart';
import 'package:parkright/screens/splash_screen.dart';
import 'package:parkright/screens/verification_screen.dart';
import 'package:parkright/screens/parking_detail_screen.dart';
import 'package:parkright/screens/parking_space_selection_screen.dart';
import 'package:parkright/screens/booking_review_screen.dart';
import 'package:parkright/screens/parking_code_screen.dart';
import 'package:parkright/screens/main_navigation_screen.dart';
import 'package:parkright/models/parking_spot.dart';
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
        
      case AppConstants.loginRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const LoginScreen(),
          duration: const Duration(milliseconds: AppConstants.shortAnimationDuration),
        );
        
      case AppConstants.verificationRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        final phoneNumber = args != null ? args['phoneNumber'] as String? : '';
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: VerificationScreen(phoneNumber: phoneNumber ?? ''),
          duration: const Duration(milliseconds: AppConstants.shortAnimationDuration),
        );
        
      case AppConstants.registerRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const RegisterScreen(),
          duration: const Duration(milliseconds: AppConstants.shortAnimationDuration),
        );
        
      case AppConstants.addVehicleRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const AddVehicleScreen(),
          duration: const Duration(milliseconds: AppConstants.shortAnimationDuration),
        );
        
      case AppConstants.homeRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const MainNavigationScreen(),
          duration: const Duration(milliseconds: AppConstants.shortAnimationDuration),
        );
      
      case AppConstants.parkingDetailRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final spot = args['spot'] as ParkingSpot;
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child: ParkingDetailScreen(spot: spot),
          duration: const Duration(milliseconds: AppConstants.shortAnimationDuration),
        );
        
      case AppConstants.parkingSpaceSelectionRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ParkingSpaceSelectionScreen(
            spot: args['spot'] as ParkingSpot,
            selectedHours: args['hours'] as int,
          ),
          duration: const Duration(milliseconds: AppConstants.shortAnimationDuration),
        );
        
      case AppConstants.bookingReviewRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: BookingReviewScreen(
            spot: args['spot'] as ParkingSpot,
            hours: args['hours'] as int,
            spaceId: args['spaceId'] as String,
            floor: args['floor'] as int,
            // If vehicle is not provided, use the default value from BookingReviewScreen constructor
            vehicle: args.containsKey('vehicle') ? args['vehicle'] as String : 'Mercedez Benz Z3',
          ),
          duration: const Duration(milliseconds: AppConstants.shortAnimationDuration),
        );
        
      case AppConstants.parkingCodeRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child: ParkingCodeScreen(
            spot: args['spot'] as ParkingSpot,
            hours: args['hours'] as int,
            spaceId: args['spaceId'] as String,
            floor: args['floor'] as int,
            vehicle: args.containsKey('vehicle') ? args['vehicle'] as String : 'Toyota Camry',
          ),
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