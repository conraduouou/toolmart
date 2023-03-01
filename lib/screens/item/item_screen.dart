import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_control_button.dart';
import 'package:toolmart/components/toolmart_back_button.dart';
import 'package:toolmart/components/toolmart_divider.dart';
import 'package:toolmart/components/toolmart_minimal_field.dart';
import 'package:toolmart/components/triangle_painter.dart';
import 'package:toolmart/components/utility_container.dart';
import 'package:toolmart/constants.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  static const id = '/home/item';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kTertiaryColor.shade70,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: _ItemScreenHeader()),
            const SliverToBoxAdapter(child: _ItemScreenDetails()),
            const SliverToBoxAdapter(
              child: UtilityContainer(
                color: Colors.white,
                child: ToolMartDivider(height: 80),
              ),
            ),
            SliverToBoxAdapter(
              child: UtilityContainer(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _RatingControls(),
                    SizedBox(height: 25),
                    ToolMartMinimalField(hintText: 'Leave a review'),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: UtilityContainer(height: 40)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const UtilityContainer(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: _Review(),
                  );
                },
                childCount: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ItemScreenHeader extends StatelessWidget {
  const _ItemScreenHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 390,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            painter: TrianglePainter(
                color: kTertiaryColor.shade50,
                startAtOrigin: false,
                yMultiplier: 0.5),
            willChange: false,
            child: Container(),
          ),
          Positioned(
            left: 32,
            bottom: 273,
            child: ToolMartBackButton(
              color: kTertiaryColor.shade70,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemScreenDetails extends StatelessWidget {
  const _ItemScreenDetails();

  @override
  Widget build(BuildContext context) {
    return UtilityContainer(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shovel',
            style: kHeadlineStyle.copyWith(
              color: kSecondaryColor.shade40,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'A sturdy shovel.',
            style: kBodyStyle.copyWith(
              color: kSecondaryColor.shade40,
            ),
          ),
          const SizedBox(height: 50),
          Text(
            'Materials:',
            style: kLabelStyle.copyWith(
              color: kTertiaryColor.shade40,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Wood, Steel',
            style: kLabelStyle.copyWith(
              color: kNeutralColor.shade60,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _ColorChoices(),
              _QuantityControls(),
            ],
          ),
        ],
      ),
    );
  }
}

class _Review extends StatelessWidget {
  const _Review();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFD9D9D9),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '3.5',
                    style: kLabelStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: kTertiaryColor.shade70,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset('assets/icons/ic-star.svg', width: 7),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'What a great item!',
                style: kLabelStyle.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RatingControls extends StatelessWidget {
  const _RatingControls();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 5; i++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Opacity(
                opacity: 0.2,
                child: SvgPicture.asset('assets/icons/ic-star.svg', width: 43),
              ),
              i < 5 ? const SizedBox(width: 15) : Container()
            ],
          ),
      ],
    );
  }
}

class _ColorChoices extends StatelessWidget {
  const _ColorChoices();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _ColorCircle(color: Color(0xFFECD4B1)),
        SizedBox(width: 10),
        _ColorCircle(color: Color(0xFF866D50)),
        SizedBox(width: 10),
        _ColorCircle(color: Color(0xFF504B4B)),
      ],
    );
  }
}

class _QuantityControls extends StatelessWidget {
  const _QuantityControls();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ToolMartControlButton.minus(),
        const SizedBox(width: 30),
        SizedBox(
          height: 32,
          width: 30,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              '123',
              style: kHeadlineStyle.copyWith(
                color: kSecondaryColor.shade40,
              ),
            ),
          ),
        ),
        const SizedBox(width: 30),
        const ToolMartControlButton.plus(),
      ],
    );
  }
}

class _ColorCircle extends StatelessWidget {
  const _ColorCircle({required this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
