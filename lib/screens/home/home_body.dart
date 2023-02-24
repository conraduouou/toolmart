import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/item_card.dart';
import 'package:toolmart/components/toolmart_textfield.dart';
import 'package:toolmart/components/triangle_painter.dart';
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
                        for (int j = i; j < i + 2; j++) const ItemCard(),
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
            foregroundPainter: TrianglePainter(color: kSecondaryColor.shade20),
            child: Container(),
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
