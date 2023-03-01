import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_control_button.dart';
import 'package:toolmart/constants.dart';

class ToolMartCartItem extends StatelessWidget {
  const ToolMartCartItem({super.key});

  static const height = 64.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Container(
            width: 90,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kTertiaryColor.shade70,
            ),
          ),
          const SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shovel',
                  style: kBodyStyle.copyWith(
                    color: kNeutralColor.shade20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'PHP 99',
                  style: kLabelStyle.copyWith(
                    color: kSecondaryColor.shade50,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(
                '1x',
                style: kBodyStyle.copyWith(
                  color: kNeutralColor.shade20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ToolMartControlButton.minus(size: 24),
                  const SizedBox(width: 7),
                  const ToolMartControlButton.plus(size: 24),
                  const SizedBox(width: 7),
                  ToolMartControlButton.error(size: 24)
                ],
              )
            ],
          ),
          const SizedBox(width: 20)
        ],
      ),
    );
  }
}
