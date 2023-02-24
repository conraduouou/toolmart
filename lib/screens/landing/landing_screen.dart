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
    return ChangeNotifierProvider(
      create: (_) => ValueNotifier(0),
      builder: (_, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: const [
              Align(
                alignment: Alignment.center,
                child: _LandingIllustrations(),
              ),
              Positioned(
                bottom: 20,
                right: 24,
                child: _SkipText(),
              )
            ],
          ),
        );
      },
    );
  }
}

class _SkipText extends StatelessWidget {
  const _SkipText();

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ValueNotifier<int>>();

    return AnimatedOpacity(
      opacity: notifier.value == 2 ? 0 : 1,
      duration: const Duration(seconds: 1),
      child: Text(
        'Skip',
        style: kBodyStyle.copyWith(
          color: kSecondaryColor.shade40,
        ),
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

  @override
  void initState() {
    super.initState();
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
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  void _onPageChanged(int page, BuildContext context) async {
    final activePageNotifier = context.read<ValueNotifier<int>>();
    activePageNotifier.value = page;
    if (page < 2) await _delayOnNext();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: imgHeight,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (page) => _onPageChanged(page, context),
              itemBuilder: (context, index) =>
                  index < 2 ? _LandingIllustration(page: index) : Container(),
            ),
          ),
        ),
        const _LandingProgress(),
      ],
    );
  }
}

class _LandingProgress extends StatelessWidget {
  const _LandingProgress();

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ValueNotifier<int>>();
    final size = MediaQuery.of(context).size;

    return AnimatedPositioned(
      bottom: notifier.value == 2 ? 20 : 80,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOutCubic,
      child: SizedBox(
        width: size.width,
        child: _LandingProgressDots(activePage: notifier.value),
      ),
    );
  }
}

class _LandingIllustration extends StatelessWidget {
  const _LandingIllustration({
    this.page = 0,
  });

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
