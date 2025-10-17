class AppConstants {
  // App information
  static const String appName = 'ParkRight';
  static const String appSlogan = 'Your Spot, Always Ready.';
  
  // Screen routes
  static const String splashRoute = '/splash';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String parkingMapRoute = '/parking-map';
  static const String bookingRoute = '/booking';
  static const String profileRoute = '/profile';
  
  // Animation durations
  static const int splashDuration = 2500; // milliseconds
  static const int shortAnimationDuration = 300; // milliseconds
  static const int mediumAnimationDuration = 500; // milliseconds
  static const int longAnimationDuration = 800; // milliseconds
  
  // Onboarding texts
  static const List<String> onboardingTitles = [
    'Find Nearby Parking Instantly',
    'Book and Pay with Ease',
    'Smart Parking, Stress-Free',
  ];
  
  static const List<String> onboardingDescriptions = [
    'Discover available parking spots around you in real time — no more circling around.',
    'Reserve your parking spot ahead and make secure payments right from the app.',
    'Get QR confirmations, live updates, and directions straight to your spot.',
  ];
}