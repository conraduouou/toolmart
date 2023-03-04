import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_back_button.dart';
import 'package:toolmart/components/toolmart_divider.dart';
import 'package:toolmart/components/triangle_painter.dart';
import 'package:toolmart/components/utility_container.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/models/helpers/storage.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  static const id = '/user';

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: kPrimaryColor.shade60,
      child: const CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _UserScreenHeader()),
          SliverToBoxAdapter(child: _UserScreenDetails()),
          SliverFillRemaining(
            hasScrollBody: false,
            child: UtilityContainer(),
          )
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
          const SliverToBoxAdapter(child: UtilityContainer(height: 80)),
          */
        ],
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
    Storage.instance.read(key: "email").then((value) {
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
          const ToolMartDivider(height: 104),
        ],
      ),
    );
  }
}

class _UserScreenHeader extends StatelessWidget {
  const _UserScreenHeader();

  @override
  Widget build(BuildContext context) {
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
          const Positioned(
            left: 32,
            bottom: 98,
            child: ToolMartBackButton(),
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
