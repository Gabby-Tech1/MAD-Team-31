import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/utils/app_router.dart';
import 'package:parkright/utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const ParkRightApp());
}

class ParkRightApp extends StatelessWidget {
  const ParkRightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppConstants.splashRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

// App implementation moved to separate screens
