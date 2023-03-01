import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';

class ToolMartControlButton extends StatelessWidget {
  const ToolMartControlButton({
    super.key,
    this.onTap,
    required this.assetPath,
    this.size,
    this.color,
    this.boxShadow,
  });

  final VoidCallback? onTap;
  final String assetPath;
  final double? size;
  final Color? color;
  final List<BoxShadow>? boxShadow;

  const ToolMartControlButton.minus({
    super.key,
    this.onTap,
    this.assetPath = 'assets/icons/ic-minus.svg',
    this.size,
    this.color,
    this.boxShadow,
  });

  const ToolMartControlButton.plus({
    super.key,
    this.onTap,
    this.assetPath = 'assets/icons/ic-plus.svg',
    this.size,
    this.color,
    this.boxShadow,
  });

  ToolMartControlButton.error({
    super.key,
    this.onTap,
    this.assetPath = 'assets/icons/ic-cross.svg',
    this.size,
    this.color = kErrorColor,
  }) : boxShadow = [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 4),
            color: Colors.black.withAlpha((1 / 5 * 255).floor()),
          ),
        ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: size ?? 35,
        width: size ?? 35,
        padding: EdgeInsets.all(size != null ? size! / 5 : 7),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? Colors.white,
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                  color: Colors.black.withAlpha((1 / 10 * 255).floor()),
                ),
              ],
        ),
        child: SvgPicture.asset(assetPath),
      ),
    );
  }
}
