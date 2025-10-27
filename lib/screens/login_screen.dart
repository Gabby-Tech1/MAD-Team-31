import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parkright/components/custom_text_field.dart';
import 'package:parkright/components/fade_slide_animation.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/utils/app_theme.dart';
import 'package:parkright/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email and password')),
      );
      return;
    }

    try {
      await context.read<AuthProvider>().signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  void _navigateToRegister() {
    Navigator.pushNamed(context, AppConstants.registerRoute);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

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
                // Title
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    'Welcome Back',
                    style: AppTextStyles.headline1.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    'Enter your email and password to continue',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Email input
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 400),
                  child: CustomTextField(
                    hintText: 'Enter your email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 16),
                // Password input
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 500),
                  child: CustomTextField(
                    hintText: 'Enter your password',
                    controller: _passwordController,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 24),
                // Sign in button
                FadeSlideAnimation(
                  delay: const Duration(milliseconds: 600),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: authProvider.isLoading ? null : _signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: authProvider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Sign In',
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
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 40),
//                 // App logo
//                 Center(
//                   child: FadeSlideAnimation(
//                     verticalOffset: 30,
//                     child: Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: AppColors.backgroundLight,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: ClipOval(
//                         child: Image.asset(
//                           'assets/images/logo.png',
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 // Welcome text
//                 FadeSlideAnimation(
//                   delay: const Duration(milliseconds: 200),
//                   child: Text(
//                     'Welcome Back!',
//                     style: AppTextStyles.headline1.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 FadeSlideAnimation(
//                   delay: const Duration(milliseconds: 300),
//                   child: Text(
//                     'Enter your mobile number to login',
//                     style: AppTextStyles.bodyMedium.copyWith(
//                       color: AppColors.textSecondary,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 // Country selection dropdown
//                 FadeSlideAnimation(
//                   delay: const Duration(milliseconds: 400),
//                   child: GestureDetector(
//                     onTap: () {
//                       // Show country selection dialog
//                       showModalBottomSheet(
//                         context: context,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(16),
//                             topRight: Radius.circular(16),
//                           ),
//                         ),
//                         builder: (context) => Container(
//                           padding: const EdgeInsets.symmetric(vertical: 20),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       'Select a Country',
//                                       style: AppTextStyles.headline2,
//                                     ),
//                                     const Spacer(),
//                                     IconButton(
//                                       onPressed: () => Navigator.pop(context),
//                                       icon: const Icon(Icons.close),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Divider(),
//                               Expanded(
//                                 child: ListView.builder(
//                                   itemCount: _countries.length,
//                                   itemBuilder: (context, index) {
//                                     final country = _countries[index];
//                                     return ListTile(
//                                       title: Text(country['name']!),
//                                       subtitle: Text(country['code']!),
//                                       onTap: () {
//                                         setState(() {
//                                           _selectedCountryCode = country['code']!;
//                                           _selectedCountry = country['name']!;
//                                         });
//                                         Navigator.pop(context);
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//                       decoration: BoxDecoration(
//                         color: AppColors.backgroundLight,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             '$_selectedCountry ($_selectedCountryCode)',
//                             style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
//                           ),
//                           const Spacer(),
//                           const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Phone number input
//                 FadeSlideAnimation(
//                   delay: const Duration(milliseconds: 500),
//                   child: CustomTextField(
//                     hintText: 'Enter phone number',
//                     controller: _phoneController,
//                     keyboardType: TextInputType.phone,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 // Send code button
//                 FadeSlideAnimation(
//                   delay: const Duration(milliseconds: 600),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _navigateToVerification,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primary, // Using primary color
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         elevation: 4, // Increased elevation for more prominence
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Text(
//                         'Send Code',
//                         style: AppTextStyles.button.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 // New user text
//                 FadeSlideAnimation(
//                   delay: const Duration(milliseconds: 700),
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: _navigateToRegister,
//                       child: RichText(
//                         text: TextSpan(
//                           text: 'New User? ',
//                           style: AppTextStyles.bodyMedium.copyWith(
//                             color: AppColors.textSecondary,
//                           ),
//                           children: [
//                             TextSpan(
//                               text: 'Get Started',
//                               style: AppTextStyles.bodyMedium.copyWith(
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }