import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parkright/components/custom_text_field.dart';
import 'package:parkright/components/fade_slide_animation.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/utils/app_theme.dart';
import 'package:parkright/providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  Future<void> _registerUser() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Validate email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    // Validate password length
    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters long')),
      );
      return;
    }

    // Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      await context.read<AuthProvider>().signUpWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _nameController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful! Please check your email to verify your account.')),
        );
        Navigator.pushReplacementNamed(context, AppConstants.addVehicleRoute);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
        );
      }
    }
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
                // Password field
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 600),
                  child: CustomTextField(
                    hintText: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 16),
                // Confirm password field
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 700),
                  child: CustomTextField(
                    hintText: 'Confirm Password',
                    controller: _confirmPasswordController,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 40),
                // Get started button
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 700),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _registerUser,
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