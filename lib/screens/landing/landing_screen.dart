import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/screens/landing/landing_sequence.dart';

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
                child: LandingSequence(),
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
