import 'package:flutter/material.dart';
import 'package:parkright/components/custom_text_field.dart';
import 'package:parkright/components/fade_slide_animation.dart';
import 'package:parkright/components/svg_image.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/utils/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  
  void _navigateToAddVehicle() {
    // In a real app, we would validate and send registration data to the server
    // For UI implementation, just navigate to the next screen
    Navigator.pushNamed(context, AppConstants.addVehicleRoute);
  }
  
  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, AppConstants.loginRoute);
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
                const SizedBox(height: 30),
                // App logo
                Center(
                  child: FadeSlideAnimation(
                  verticalOffset: 30,
                  child: Container(
                    width: 80,
                    height: 80,
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
                const SizedBox(height: 30),
                // Get started text
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    'Get Started',
                    style: AppTextStyles.headline2,
                  ),
                ),
                const SizedBox(height: 8),
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    'Let\'s create your account',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Name field
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 400),
                  child: CustomTextField(
                    hintText: 'Name',
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
                const SizedBox(height: 16),
                // Email field
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 500),
                  child: CustomTextField(
                    hintText: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 16),
                // Phone number field
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 600),
                  child: CustomTextField(
                    hintText: 'Phone Number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(height: 40),
                // Get started button
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 700),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToAddVehicle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.buttonText,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Get Started',
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.buttonText,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Login link
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 800),
                  child: Center(
                    child: GestureDetector(
                      onTap: _navigateToLogin,
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: 'Login',
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