import 'package:flutter/material.dart';
import 'package:parkright/utils/app_theme.dart';

class OnboardingTitle extends StatelessWidget {
  final String title;
  final String description;
  final TextAlign textAlign;

  const OnboardingTitle({
    Key? key,
    required this.title,
    required this.description,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTextStyles.headline2,
          textAlign: textAlign,
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: AppTextStyles.bodyMedium,
          textAlign: textAlign,
        ),
      ],
    );
  }
}