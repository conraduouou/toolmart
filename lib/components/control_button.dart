import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ControlButton extends StatelessWidget {
  const ControlButton({
    super.key,
    this.onTap,
    required this.assetPath,
  });

  final VoidCallback? onTap;
  final String assetPath;

  const ControlButton.minus({
    super.key,
    this.onTap,
    this.assetPath = 'assets/icons/ic-minus.svg',
  });

  const ControlButton.plus({
    super.key,
    this.onTap,
    this.assetPath = 'assets/icons/ic-plus.svg',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
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
