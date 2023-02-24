import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_textfield.dart';
import 'package:toolmart/constants.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: _HomeHeader()),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All items',
                  style: kTitleStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kNeutralColor.shade30,
                  ),
                ),
                const SizedBox(height: 20),
                for (int i = 0; i < 10; i += 2)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int j = i; j < i + 2; j++) const _ItemCard(),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard();

  static const _height = 201.0;
  static const _width = 165.0;

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
      height: _height,
      width: _width,
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
            child: _ItemLabel(width: _width),
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

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          CustomPaint(
            foregroundPainter: TrianglePainter(),
            child: Container(color: kSecondaryColor.shade40),
          ),
          Positioned(
            right: 24,
            bottom: 148,
            child: SvgPicture.asset('assets/icons/ic-settings.svg'),
          ),
          Positioned(
            bottom: 120,
            child: SizedBox(
              width: size.width,
              child: Text(
                'Discover',
                textAlign: TextAlign.center,
                style: kHeadlineStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 45,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: size.width,
              child: const ToolMartTextfield(
                hintText: 'Search',
                backgroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()
      ..color = kSecondaryColor.shade20
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(65, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 39)
      ..lineTo(65, size.height)
      ..close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
