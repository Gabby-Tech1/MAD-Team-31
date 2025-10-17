import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String assetName;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const SvgImage({
    Key? key,
    required this.assetName,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      fit: fit,
    );
  }
}