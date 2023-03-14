import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/on_tap_wrapper.dart';
import 'package:toolmart/components/toolmart_back_button.dart';
import 'package:toolmart/components/toolmart_divider.dart';
import 'package:toolmart/components/triangle_painter.dart';
import 'package:toolmart/components/utility_container.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/models/helpers/toolmart_storage.dart';
import 'package:toolmart/screens/transaction/transaction_screen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  static const id = '/user';

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: kPrimaryColor.shade60,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: _UserScreenHeader()),
          const SliverToBoxAdapter(child: _UserScreenDetails()),
          const SliverToBoxAdapter(
            child: UtilityContainer(
              child: ToolMartDivider(height: 104),
            ),
          ),
          SliverToBoxAdapter(
            child: UtilityContainer(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Text(
                'Transactions',
                style: kTitleStyle.copyWith(
                  color: kNeutralColor.shade30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // if index is last item
                if (index == 2 - 1) return const _TransactionCard();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _TransactionCard(),
                    UtilityContainer(
                      height: 16,
                    )
                  ],
                );
              },
              childCount: 2,
            ),
          ),
          const SliverToBoxAdapter(child: UtilityContainer(height: 80)),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: UtilityContainer(),
          ),
          /*
          SliverToBoxAdapter(
            child: UtilityContainer(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Items bought',
                    style: kTitleStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kNeutralColor.shade30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: ToolMartItemCard.height + 25,
            delegate: SliverChildListDelegate([
              for (int i = 0; i < (9 / 2).ceil(); i++)
                // 9 in this case, the itemCount
                UtilityContainer(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int j = i * 2, n = j + 2; j < n && j < 9; j++)
                        const ToolMartItemCard(),
                    ],
                  ),
                ),
            ]),
          ),
          */
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  const _TransactionCard();

  @override
  Widget build(BuildContext context) {
    return OnTapWrapper(
      onTap: () => Navigator.of(context).pushNamed(TransactionScreen.id),
      child: UtilityContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            const SizedBox(width: 14),
            SvgPicture.asset('assets/icons/ic-bag.svg'),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'E12-001',
                  style: kLabelStyle.copyWith(
                    color: kNeutralVariant.shade30,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'PHP 99.00',
                  style: kLabelStyle.copyWith(
                    color: kNeutralColor.shade50,
                    fontWeight: FontWeight.normal,
                    fontSize: 10,
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              'February 28, 2023',
              style: kLabelStyle.copyWith(
                fontWeight: FontWeight.normal,
                color: kNeutralColor.shade50,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _UserScreenDetails extends StatefulWidget {
  const _UserScreenDetails();

  @override
  State<_UserScreenDetails> createState() => _UserScreenDetailsState();
}

class _UserScreenDetailsState extends State<_UserScreenDetails> {
  String? _email;

  @override
  void initState() {
    ToolMartStorage.instance.read(key: "email").then((value) {
      setState(() {
        _email = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UtilityContainer(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 67, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _email?.split("@")[0] ?? 'User Name',
            style: kHeadlineStyle.copyWith(
              color: kSecondaryColor.shade40,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _email ?? 'user@email.com',
            style: kBodyStyle.copyWith(
              color: kSecondaryColor.shade40,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserScreenHeader extends StatelessWidget {
  const _UserScreenHeader();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;

    return SizedBox(
      height: 215,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            painter: TrianglePainter(
              color: kPrimaryColor.shade40,
              startAtOrigin: false,
            ),
            willChange: false,
            child: Container(),
          ),
          Positioned(
            left: 32,
            top: topPadding + 25,
            child: const ToolMartBackButton(),
          ),
          Positioned(
            left: 22,
            bottom: -59,
            child: Container(
              width: 118,
              height: 118,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
            ),
          )
        ],
      ),
    );
  }
}
