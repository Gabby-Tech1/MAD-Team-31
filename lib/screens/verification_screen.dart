import 'package:flutter/material.dart';
import 'package:parkright/components/fade_slide_animation.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/utils/app_theme.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const VerificationScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  String get _verificationCode {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  void initState() {
    super.initState();
    // Set up listeners to auto-focus the next input
    for (int i = 0; i < 3; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1) {
          _focusNodes[i + 1].requestFocus();
        }
      });
    }
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

  void _navigateToRegister() {
    // In a real app, we would validate the OTP here
    // For UI implementation, navigate directly to the home screen as requested
    Navigator.pushNamedAndRemoveUntil(
      context, 
      AppConstants.homeRoute,
      (route) => false
    );
  }

  void _resendCode() {
    // In a real app, we would implement resending code functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Code resent!')),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  'Please type the code we sent to\n${widget.phoneNumber}',
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
                    children: List.generate(4, (index) {
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
                            // Display • for filled digits after the first two
                            hintText: index > 1 ? '•' : '',
                            hintStyle: AppTextStyles.headline2.copyWith(
                              color: AppColors.textLight,
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isEmpty && index > 0) {
                              // Move focus to previous field on backspace
                              _focusNodes[index - 1].requestFocus();
                            } else if (_verificationCode.length == 4) {
                              // If all digits entered, validate and proceed
                              _navigateToRegister();
                            }
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const Spacer(),
              // Refresh button
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 300),
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.refresh,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    onPressed: _resendCode,
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