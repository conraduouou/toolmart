import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';

class ToolMartRadioButton extends StatelessWidget {
  const ToolMartRadioButton({
    super.key,
    this.isSelected = false,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: kPrimaryColor.shade60,
        ),
      ),
      child: Container(
        height: 7.5,
        width: 7.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? kPrimaryColor.shade60 : Colors.transparent,
        ),
      ),
    );
  }
}
