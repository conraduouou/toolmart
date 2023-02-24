import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_textfield.dart';
import 'package:toolmart/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const id = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: _HomeHeader()),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'All items',
                  style: kTitleStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kNeturalColor.shade30,
                  ),
                )
              ]),
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
