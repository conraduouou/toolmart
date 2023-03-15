import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/toolmart_app.dart';

class ToolMartBackButton extends StatelessWidget {
  const ToolMartBackButton({
    super.key,
    this.color,
    this.boxShadow,
  });

  final Color? color;
  final List<BoxShadow>? boxShadow;

  void popLogic(BuildContext context) {
    final navigator = Navigator.of(context);

    if (navigator == homeNavKey.currentState!) {
      final notifier = context.read<ValueNotifier<int>>(); // page notifier

      if (navigator.canPop()) {
        navigator.maybePop();
        return;
      }

      if (notifier.value != 0) {
        notifier.value = 0;
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => popLogic(context),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: boxShadow,
        ),
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          'assets/icons/ic-arrow.svg',
          colorFilter: ColorFilter.mode(
            color ?? kPrimaryColor.shade60,
            BlendMode.srcATop,
          ),
        ),
      ),
    );
  }
}
