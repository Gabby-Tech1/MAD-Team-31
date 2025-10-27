import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parkright/components/fade_slide_animation.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/utils/app_theme.dart';
import 'package:parkright/providers/auth_provider.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String? _phoneNumber;
  Map<String, dynamic>? _userDetails;

  String get _otpCode {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  void initState() {
    super.initState();
    // Set up listeners to auto-focus the next input
    for (int i = 0; i < _controllers.length - 1; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1) {
          _focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _phoneNumber = args?['phoneNumber'];
    _userDetails = args?['userDetails'];
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _verifyOTP() async {
    if (_otpCode.length != 6 || _phoneNumber == null) return;

    try {
      await context.read<AuthProvider>().verifyOTP(_phoneNumber!, _otpCode, userDetails: _userDetails);

      if (mounted) {
        // Navigate to add vehicle screen for new users, or home for existing users
        final targetRoute = _userDetails != null ? AppConstants.addVehicleRoute : AppConstants.homeRoute;
        Navigator.pushNamedAndRemoveUntil(
          context,
          targetRoute,
          (route) => false
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  void _resendCode() {
    if (_phoneNumber != null) {
      try {
        context.read<AuthProvider>().signIn(_phoneNumber!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Code resent!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error resending code: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              FadeSlideAnimation(
                child: Text(
                  'Enter your code',
                  style: AppTextStyles.headline2,
                ),
              ),
              const SizedBox(height: 12),
              // Subtitle with phone number
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Please type the code we sent to\n${_phoneNumber ?? 'your phone'}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Code input fields
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 40,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: AppTextStyles.headline2,
                          decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            hintText: '•',
                            hintStyle: AppTextStyles.headline2.copyWith(
                              color: AppColors.textLight,
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isEmpty && index > 0) {
                              // Move focus to previous field on backspace
                              _focusNodes[index - 1].requestFocus();
                            } else if (_otpCode.length == 6) {
                              // If all digits entered, validate and proceed
                              _verifyOTP();
                            }
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Verify button
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: authProvider.isLoading || _otpCode.length != 6 ? null : _verifyOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: authProvider.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Verify'),
                  ),
                ),
              ),
              const Spacer(),
              // Refresh button
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 400),
                child: Center(
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.refresh,
                          color: AppColors.primary,
                          size: 32,
                        ),
                        onPressed: authProvider.isLoading ? null : _resendCode,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Resend Code',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
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
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Title
//               FadeSlideAnimation(
//                 child: Text(
//                   'Enter your code',
//                   style: AppTextStyles.headline2,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               // Subtitle with phone number
//               FadeSlideAnimation(
//                 delay: const Duration(milliseconds: 100),
//                 child: Text(
//                   'Please type the code we sent to\n${widget.phoneNumber}',
//                   style: AppTextStyles.bodyMedium.copyWith(
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//               // Code input fields
//               FadeSlideAnimation(
//                 delay: const Duration(milliseconds: 200),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                   decoration: BoxDecoration(
//                     color: AppColors.backgroundLight,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(4, (index) {
//                       return SizedBox(
//                         width: 40,
//                         child: TextField(
//                           controller: _controllers[index],
//                           focusNode: _focusNodes[index],
//                           textAlign: TextAlign.center,
//                           keyboardType: TextInputType.number,
//                           maxLength: 1,
//                           style: AppTextStyles.headline2,
//                           decoration: InputDecoration(
//                             counterText: '',
//                             border: InputBorder.none,
//                             // Display • for filled digits after the first two
//                             hintText: index > 1 ? '•' : '',
//                             hintStyle: AppTextStyles.headline2.copyWith(
//                               color: AppColors.textLight,
//                             ),
//                           ),
//                           onChanged: (value) {
//                             if (value.isEmpty && index > 0) {
//                               // Move focus to previous field on backspace
//                               _focusNodes[index - 1].requestFocus();
//                             } else if (_verificationCode.length == 4) {
//                               // If all digits entered, validate and proceed
//                               _navigateToHome();
//                             }
//                           },
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               // Refresh button
//               FadeSlideAnimation(
//                 delay: const Duration(milliseconds: 300),
//                 child: Center(
//                   child: IconButton(
//                     icon: const Icon(
//                       Icons.refresh,
//                       color: AppColors.primary,
//                       size: 32,
//                     ),
//                     onPressed: _resendCode,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }