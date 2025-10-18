import 'package:flutter/material.dart';
import 'package:parkright/components/custom_text_field.dart';
import 'package:parkright/components/fade_slide_animation.dart';
import 'package:parkright/components/svg_image.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/utils/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '+233'; // Default to Ghana code
  String _selectedCountry = 'Ghana'; // Default to Ghana
  
  // List of countries with their dial codes
  final List<Map<String, String>> _countries = [
    {'name': 'Ghana', 'code': '+233'},
    {'name': 'Nigeria', 'code': '+234'},
    {'name': 'South Africa', 'code': '+27'},
    {'name': 'Kenya', 'code': '+254'},
    {'name': 'United States', 'code': '+1'},
    {'name': 'United Kingdom', 'code': '+44'},
    {'name': 'India', 'code': '+91'},
    {'name': 'China', 'code': '+86'},
    {'name': 'Canada', 'code': '+1'},
    {'name': 'Australia', 'code': '+61'},
    {'name': 'Germany', 'code': '+49'},
    {'name': 'France', 'code': '+33'},
    {'name': 'Brazil', 'code': '+55'},
    {'name': 'Egypt', 'code': '+20'},
    {'name': 'Morocco', 'code': '+212'},
  ];
  
  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
  
  void _navigateToVerification() {
    // Normally would validate phone number here
    final phoneNumber = _selectedCountryCode + _phoneController.text.trim();
    
    // For UI implementation, just navigate to verification
    Navigator.pushNamed(
      context, 
      AppConstants.verificationRoute,
      arguments: {'phoneNumber': phoneNumber}
    );
  }
  
  void _navigateToRegister() {
    Navigator.pushNamed(context, AppConstants.registerRoute);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // App logo
                Center(
                  child: FadeSlideAnimation(
                    verticalOffset: 30,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Welcome text
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    'Welcome Back!',
                    style: AppTextStyles.headline1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    'Enter your mobile number to login',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Country selection dropdown
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 400),
                  child: GestureDetector(
                    onTap: () {
                      // Show country selection dialog
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        builder: (context) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Select a Country',
                                      style: AppTextStyles.headline2,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _countries.length,
                                  itemBuilder: (context, index) {
                                    final country = _countries[index];
                                    return ListTile(
                                      title: Text(country['name']!),
                                      subtitle: Text(country['code']!),
                                      onTap: () {
                                        setState(() {
                                          _selectedCountryCode = country['code']!;
                                          _selectedCountry = country['name']!;
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '$_selectedCountry ($_selectedCountryCode)',
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                          ),
                          const Spacer(),
                          const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Phone number input
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 500),
                  child: CustomTextField(
                    hintText: 'Enter phone number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(height: 24),
                // Send code button
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 600),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToVerification,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary, // Using primary color
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 4, // Increased elevation for more prominence
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Send Code',
                        style: AppTextStyles.button.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // New user text
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 700),
                  child: Center(
                    child: GestureDetector(
                      onTap: _navigateToRegister,
                      child: RichText(
                        text: TextSpan(
                          text: 'New User? ',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: 'Get Started',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}