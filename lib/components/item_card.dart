import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/constants.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  static const height = 201.0;
  static const width = 165.0;

  static final _boxShadow = [
    BoxShadow(
      blurRadius: 15,
      offset: const Offset(0, 4),
      color: Colors.black.withAlpha((8 / 100 * 255).floor()),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: kTertiaryColor.shade70,
              borderRadius: BorderRadius.circular(15),
              boxShadow: _boxShadow,
            ),
          ),
          const Positioned(
            bottom: 0,
            child: _ItemLabel(width: width),
          ),
        ],
      ),
    );
  }
}

class _ItemLabel extends StatelessWidget {
  const _ItemLabel({
    required this.width,
  });

  final double width;

  static const _labelHeight = 75.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _labelHeight,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 10,
            child: Text(
              'Shovel',
              style: kLabelStyle.copyWith(
                color: kNeutralColor.shade30,
              ),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 9,
            child: Text(
              'PHP 99',
              style: kLabelStyle.copyWith(
                color: kSecondaryColor.shade50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
