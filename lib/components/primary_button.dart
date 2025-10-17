import 'package:flutter/material.dart';
import 'package:parkright/utils/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final bool isOutlined;
  final EdgeInsets padding;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.isOutlined = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : AppColors.buttonBackground,
          foregroundColor: isOutlined ? AppColors.primary : AppColors.buttonText,
          padding: padding,
          elevation: isOutlined ? 0 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isOutlined 
                ? BorderSide(color: AppColors.primary, width: 1)
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: AppTextStyles.button.copyWith(
            color: isOutlined ? AppColors.primary : AppColors.buttonText,
          ),
        ),
      ),
    );
  }
}