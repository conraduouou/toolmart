import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/control_button.dart';
import 'package:toolmart/constants.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            children: [
              Text(
                'Shovel',
                style: kBodyStyle.copyWith(
                  color: kNeutralColor.shade20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
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
                const ControlButton.minus(size: 24),
                const SizedBox(width: 7),
                const ControlButton.plus(size: 24),
                const SizedBox(width: 7),
                ControlButton.error(size: 24)
              ],
            )
          ],
        ),
        const SizedBox(width: 20)
      ],
    );
  }
}
