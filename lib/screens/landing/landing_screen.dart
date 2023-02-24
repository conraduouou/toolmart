import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/constants.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  static const id = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.center,
            child: _LandingIllustrations(),
          ),
          Positioned(
            bottom: 20,
            right: 24,
            child: Text(
              'Skip',
              style: kBodyStyle.copyWith(
                color: kSecondaryColor.shade40,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _LandingIllustrations extends StatefulWidget {
  const _LandingIllustrations();

  @override
  State<_LandingIllustrations> createState() => _LandingIllustrationsState();
}

class _LandingIllustrationsState extends State<_LandingIllustrations> {
  static const imgHeight = 380.0;

  PageController controller = PageController();
  late ValueNotifier<int> activePageNotifier;

  @override
  void initState() {
    super.initState();
    activePageNotifier = ValueNotifier(0);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _delayOnNext();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _delayOnNext() async {
    await Future.delayed(const Duration(seconds: 3));

    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _onPageChanged(int page) async {
    activePageNotifier.value = page;
    if (page < 1) await _delayOnNext();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: imgHeight,
          child: PageView.builder(
            controller: controller,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) => _LandingIllustration(page: index),
          ),
        ),
        const SizedBox(height: 93),
        ChangeNotifierProvider.value(
          value: activePageNotifier,
          builder: (context, child) {
            final page = context.watch<ValueNotifier<int>>().value;
            return _LandingProgress(activePage: page);
          },
        ),
      ],
    );
  }
}

class _LandingIllustration extends StatelessWidget {
  const _LandingIllustration({this.page = 0});

  final int page;

  static const landingHeight = 275.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/illustrations/landing-${page + 1}.svg',
          height: landingHeight,
        ),
        const SizedBox(height: 30),
        Text(
          page == 0 ? 'Get new tools!' : 'Stay updated!',
          style: kHeadlineStyle.copyWith(
            color: kSecondaryColor.shade50,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          page == 0
              ? 'Get everything you need.'
              : 'Be on the hunt for new tools!',
          style: kTitleStyle.copyWith(
            color: kSecondaryColor.shade50,
          ),
        )
      ],
    );
  }
}

class _LandingProgress extends StatelessWidget {
  const _LandingProgress({
    required this.activePage,
  });

  final int activePage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LandingProgressDot(isActive: activePage == 0),
        const SizedBox(width: 15),
        _LandingProgressDot(isActive: activePage == 1),
        const SizedBox(width: 15),
        _LandingProgressDot(isActive: activePage == 2),
      ],
    );
  }
}

class _LandingProgressDot extends StatelessWidget {
  const _LandingProgressDot({
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? kPrimaryColor.shade70 : kPrimaryColor.shade95,
      ),
      width: 13,
      height: 13,
    );
  }
}
