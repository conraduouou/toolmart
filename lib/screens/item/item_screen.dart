import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/on_tap_wrapper.dart';
import 'package:toolmart/components/toolmart_control_button.dart';
import 'package:toolmart/components/toolmart_back_button.dart';
import 'package:toolmart/components/toolmart_divider.dart';
import 'package:toolmart/components/toolmart_minimal_field.dart';
import 'package:toolmart/components/toolmart_sticky_button.dart';
import 'package:toolmart/components/triangle_painter.dart';
import 'package:toolmart/components/utility_container.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/models/core/item.dart';
import 'package:toolmart/providers/item/item_provider.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({
    super.key,
    required this.itemDetails,
  });

  static const id = '/home/item';
  final Item itemDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ChangeNotifierProvider(
        create: (_) => ItemProvider(itemDetails),
        builder: (context, child) {
          final provider = context.read<ItemProvider>();

          return Scaffold(
            backgroundColor: kTertiaryColor.shade70,
            bottomNavigationBar: ToolMartStickyButton(
              text: 'Add to Cart',
              onTap: () => provider.onAddTap(context),
            ),
            body: child!,
          );
        },
        child: CustomScrollView(
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
            const SliverToBoxAdapter(child: _RatingControls()),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return UtilityContainer(
                    padding:
                        EdgeInsets.fromLTRB(20, index == 0 ? 5 : 0, 20, 16),
                    child: const _Review(),
                  );
                },
                childCount: 4,
              ),
            ),
            const SliverToBoxAdapter(child: UtilityContainer(height: 80))
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

  String _fold(List<String>? items) {
    return items?.fold('', (p, e) => '${_stringCheck(p) ? '$p, ' : ''}$e') ??
        '';
  }

  bool _stringCheck(String? p) {
    return p != null && p.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final itemDetails = context.read<ItemProvider>().item;

    return UtilityContainer(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemDetails.name!,
            style: kHeadlineStyle.copyWith(
              color: kSecondaryColor.shade40,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            itemDetails.details!,
            style: kBodyStyle.copyWith(
              color: kSecondaryColor.shade40,
            ),
          ),
          const SizedBox(height: 50),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Materials:',
                    style: kLabelStyle.copyWith(
                      color: kTertiaryColor.shade40,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _fold(itemDetails.materials),
                    style: kLabelStyle.copyWith(
                      color: kNeutralColor.shade60,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'PHP ${itemDetails.price!.toStringAsFixed(2)}',
                style: kTitleStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: kTertiaryColor.shade60,
                ),
              )
            ],
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
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width - 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                  Flexible(
                    child: Text(
                      'What a great item!',
                      style: kLabelStyle.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingControls extends StatelessWidget {
  const _RatingControls();

  @override
  Widget build(BuildContext context) {
    final stars = context.select<ItemProvider, int>((p) => p.stars);
    final provider = context.read<ItemProvider>();

    return UtilityContainer(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OnTapWrapper(
                      onTap: () => provider.onStarTap(i),
                      child: Opacity(
                        opacity: i + 1 <= stars ? 1 : 0.2,
                        child: SvgPicture.asset(
                          'assets/icons/ic-star.svg',
                          width: 43,
                        ),
                      ),
                    ),
                    i < 5 ? const SizedBox(width: 15) : Container()
                  ],
                ),
            ],
          ),
          const SizedBox(height: 25),
          ToolMartMinimalField(
            hintText: 'Leave a review',
            onChanged: provider.onReviewChanged,
            onSendTap: () => provider.onSendTap(context),
          ),
          const SizedBox(height: 40),
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
    final provider = context.read<ItemProvider>();
    final toOrder = context.select<ItemProvider, int>((p) => p.item.toOrder);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ToolMartControlButton.minus(
          onTap: provider.onMinusTap,
        ),
        const SizedBox(width: 30),
        SizedBox(
          height: 32,
          width: 30,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              toOrder.toString(),
              style: kHeadlineStyle.copyWith(
                color: kSecondaryColor.shade40,
              ),
            ),
          ),
        ),
        const SizedBox(width: 30),
        ToolMartControlButton.plus(
          onTap: provider.onPlusTap,
        ),
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
