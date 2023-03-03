import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_item_card.dart';
import 'package:toolmart/components/toolmart_textfield.dart';
import 'package:toolmart/components/triangle_painter.dart';
import 'package:toolmart/components/utility_container.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/providers/home/home_provider.dart';
import 'package:toolmart/screens/home/home_overlay.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const id = '${HomeOverlay.id}/home';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ColoredBox(
          color: kSecondaryColor.shade40,
          child: const _HomeScreenBody(),
        ),
      ),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: _HomeScreenHeader()),
        SliverToBoxAdapter(
          child: UtilityContainer(
            padding: const EdgeInsets.all(20),
            child: provider.inAsync
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 50),
                        CircularProgressIndicator(
                          color: kPrimaryColor.shade60,
                        ),
                      ],
                    ),
                  )
                : Text(
                    'All items',
                    style: kTitleStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kNeutralColor.shade30,
                    ),
                  ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: ToolMartItemCard.height + 25,
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final actualIndex = index * 2;
              final itemCount = provider.items.length;

              return UtilityContainer(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int j = actualIndex;
                        j < actualIndex + 2 && j < itemCount;
                        j++)
                      const ToolMartItemCard(),
                  ],
                ),
              );
            },
            childCount: (9 / 2).ceil(),
          ),
        )
      ],
    );
  }
}

class _HomeScreenHeader extends StatelessWidget {
  const _HomeScreenHeader();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          CustomPaint(
            foregroundPainter: TrianglePainter(
              color: kSecondaryColor.shade20,
              startAtOrigin: false,
            ),
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
