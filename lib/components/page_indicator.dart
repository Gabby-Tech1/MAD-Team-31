import 'package:flutter/material.dart';
import 'package:parkright/utils/app_theme.dart';

class PageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  final double dotSize;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;

  const PageIndicator({
    Key? key,
    required this.pageCount,
    required this.currentPage,
    this.dotSize = 8.0,
    this.spacing = 8.0,
    this.activeColor = AppColors.primary,
    this.inactiveColor = AppColors.backgroundDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pageCount, (index) {
        bool isActive = index == currentPage;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          height: dotSize,
          width: isActive ? dotSize * 3 : dotSize,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(dotSize / 2),
          ),
        );
      }),
    );
  }
}