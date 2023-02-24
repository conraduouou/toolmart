import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/constants.dart';

class ToolMartButton extends StatefulWidget {
  const ToolMartButton({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.height,
    this.width,
    this.border,
    this.fontWeight,
    this.onTap,
  });

  final double? height;
  final double? width;
  final String text;
  final Border? border;
  final Color? color;
  final Color? textColor;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;

  ToolMartButton.primary({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.border,
    this.fontWeight = FontWeight.bold,
    this.textColor = Colors.white,
    this.onTap,
  }) : color = kPrimaryColor.shade60;

  ToolMartButton.secondary({
    super.key,
    required this.text,
    this.color = Colors.transparent,
    this.height,
    this.width,
    this.fontWeight,
    this.onTap,
  })  : border = Border.all(width: 2, color: kPrimaryColor),
        textColor = kPrimaryColor.shade60;

  @override
  State<ToolMartButton> createState() => _ToolMartButtonState();
}

class _ToolMartButtonState extends State<ToolMartButton> {
  static const _height = 55.0;
  static const _borderRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: widget.height ?? _height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              color: widget.color,
            ),
            child: Text(
              widget.text,
              style: kBodyStyle.copyWith(
                fontWeight: widget.fontWeight,
                color: widget.textColor,
              ),
            ),
          ),
          Container(
            height: widget.height ?? _height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              border: widget.border,
            ),
          )
        ],
      ),
    );
  }
}
