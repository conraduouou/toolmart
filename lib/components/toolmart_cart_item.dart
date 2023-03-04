import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_control_button.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/models/core/cart_item.dart';

class ToolMartCartItem extends StatelessWidget {
  const ToolMartCartItem({
    super.key,
    required this.cartItem,
    this.onMinusTap,
    this.onPlusTap,
    this.onDeleteTap,
  });

  static const height = 64.0;
  final CartItem cartItem;

  final VoidCallback? onMinusTap;
  final VoidCallback? onPlusTap;
  final VoidCallback? onDeleteTap;

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
                  cartItem.name!,
                  style: kBodyStyle.copyWith(
                    color: kNeutralColor.shade20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'PHP ${cartItem.price!.toStringAsFixed(2)}',
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
                '${cartItem.itemQuantity}x',
                style: kBodyStyle.copyWith(
                  color: kNeutralColor.shade20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ToolMartControlButton.minus(
                    size: 24,
                    onTap: onMinusTap,
                  ),
                  const SizedBox(width: 7),
                  ToolMartControlButton.plus(
                    size: 24,
                    onTap: onPlusTap,
                  ),
                  const SizedBox(width: 7),
                  ToolMartControlButton.error(
                    size: 24,
                    onTap: onDeleteTap,
                  )
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
