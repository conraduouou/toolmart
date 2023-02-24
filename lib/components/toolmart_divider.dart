import 'package:flutter/material.dart';

class ToolMartDivider extends StatelessWidget {
  const ToolMartDivider({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      alignment: Alignment.center,
      child: Divider(
        height: height,
        thickness: 1,
        color: const Color(0xFFEBEBEB),
      ),
    );
  }
}
