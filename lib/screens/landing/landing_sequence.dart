import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/screens/landing/login_elements.dart';

class LandingSequence extends StatefulWidget {
  const LandingSequence({super.key});

  @override
  State<LandingSequence> createState() => _LandingSequenceState();
}

class _LandingSequenceState extends State<LandingSequence> {
  static const _nextPageDuration = Duration(milliseconds: 500);
  static const _imgHeight = 380.0;

  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _delayOnNext(0);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _delayOnNext(int page) async {
    await Future.delayed(const Duration(seconds: 3));
    controller.nextPage(
      duration: _nextPageDuration,
      curve: Curves.easeOutCubic,
    );
  }

  void _onPageChanged(int page, BuildContext context) async {
    final activePageNotifier = context.read<ValueNotifier<int>>();
    activePageNotifier.value = page;

    // Show login after a 3-second delay when current page is 1
    if (page == 1) {
      await Future.delayed(const Duration(seconds: 3));
      activePageNotifier.value++;
      return;
    }

    if (page < 2) await _delayOnNext(page);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ValueNotifier<int>>();

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: AnimatedSwitcher(
            duration: _nextPageDuration,
            child: notifier.value < 2
                ? SizedBox(
                    height: _imgHeight,
                    child: PageView.builder(
                      controller: controller,
                      onPageChanged: (page) => _onPageChanged(page, context),
                      itemBuilder: (context, index) =>
                          _LandingIllustration(page: index),
                    ),
                  )
                : const LoginElements(),
          ),
        ),
        const _LandingProgress(),
      ],
    );
  }
}

class _LandingIllustration extends StatelessWidget {
  const _LandingIllustration({
    this.page = 0,
  });

  static const _landingHeight = 275.0;

  final int page;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/illustrations/landing-${page + 1}.svg',
          height: _landingHeight,
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
  const _LandingProgress();

  static const _toLoginAnimation = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ValueNotifier<int>>();
    final size = MediaQuery.of(context).size;

    return AnimatedPositioned(
      bottom: notifier.value == 2 ? 20 : 80, // when page shows LoginElements
      duration: _toLoginAnimation,
      curve: Curves.easeOutCubic,
      child: SizedBox(
        width: size.width,
        child: _LandingProgressDots(activePage: notifier.value),
      ),
    );
  }
}

class _LandingProgressDots extends StatelessWidget {
  const _LandingProgressDots({
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
