import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/control_button.dart';
import 'package:toolmart/components/toolmart_back_button.dart';
import 'package:toolmart/components/toolmart_divider.dart';
import 'package:toolmart/components/triangle_painter.dart';
import 'package:toolmart/constants.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  static const id = '/home/item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTertiaryColor.shade70,
      body: const CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _ItemScreenHeader(),
          ),
          SliverToBoxAdapter(
            child: _ItemScreenBody(),
          )
        ],
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
              yCor: 210,
            ),
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

class _ItemScreenBody extends StatelessWidget {
  const _ItemScreenBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
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
          const ToolMartDivider(height: 80),
        ],
      ),
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
        const ControlButton.minus(),
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
        const ControlButton.plus(),
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
