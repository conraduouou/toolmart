import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/cart_item.dart';
import 'package:toolmart/components/item_card.dart';
import 'package:toolmart/components/sticky_button.dart';
import 'package:toolmart/components/toolmart_back_button.dart';
import 'package:toolmart/components/toolmart_divider.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/screens/home/home_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const id = '${HomeScreen.id}/cart';
  static const _itemCount = 11;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const StickyButton(text: 'Checkout'),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: topPadding + 25),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 32),
                  ToolMartBackButton(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                        color: Colors.black.withAlpha((2 / 25 * 255).floor()),
                      )
                    ],
                  ),
                  const SizedBox(width: 25),
                  Text(
                    'Cart',
                    style: kHeadlineStyle.copyWith(
                      color: kPrimaryColor.shade60,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ]),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 60)),
          SliverList(
            delegate: SliverChildListDelegate([
              for (int i = 0; i < 4; i++)
                Column(
                  children: [
                    const CartItem(),
                    i < 3 ? const SizedBox(height: 12) : Container(),
                  ],
                ),
            ]),
          ),
          const SliverToBoxAdapter(child: ToolMartDivider(height: 86)),
          SliverPadding(
            padding: const EdgeInsets.only(left: 20),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Recommended',
                style: kTitleStyle.copyWith(
                  color: kNeutralColor.shade30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverFixedExtentList(
              itemExtent: ItemCard.height + 25,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final trueIndex = index * 2;
                  final items = <Widget>[];

                  for (int i = trueIndex;
                      i < trueIndex + 2 && i < _itemCount;
                      i++) {
                    items.add(const ItemCard());
                  }

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: items,
                      ),
                      const SizedBox(height: 25)
                    ],
                  );
                },
                // because we're going to create items in 2s
                childCount: (_itemCount / 2).ceil(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}