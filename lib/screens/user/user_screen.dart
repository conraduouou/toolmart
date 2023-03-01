import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_navbar.dart';
import 'package:toolmart/components/toolmart_item_card.dart';
import 'package:toolmart/components/toolmart_back_button.dart';
import 'package:toolmart/components/toolmart_divider.dart';
import 'package:toolmart/components/triangle_painter.dart';
import 'package:toolmart/constants.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  static const id = '/user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor.shade60,
      bottomNavigationBar: const ToolMartNavBar(),
      body: const CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _UserScreenHeader(),
          ),
          SliverToBoxAdapter(
            child: _UserScreenDetails(),
          )
        ],
      ),
    );
  }
}

class _UserScreenDetails extends StatelessWidget {
  const _UserScreenDetails();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 67, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Name',
            style: kHeadlineStyle.copyWith(
              color: kSecondaryColor.shade40,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'user@email.com',
            style: kBodyStyle.copyWith(
              color: kSecondaryColor.shade40,
            ),
          ),
          const ToolMartDivider(height: 104),
          Text(
            'Items bought',
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
                  for (int j = i; j < i + 2; j++) const ToolMartItemCard(),
                ],
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
