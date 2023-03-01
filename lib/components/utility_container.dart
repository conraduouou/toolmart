import 'package:flutter/material.dart';

class UtilityContainer extends StatelessWidget {
  /// A utility container for aesthetic purposes in slivers.
  ///
  /// Until this [issue](https://github.com/flutter/flutter/issues/14288) is solved,
  /// this will be the workaround for setting background color in slivers and ensuring
  /// they don't have flashing lines appearing as they get scrolled.
  const UtilityContainer({
    super.key,
    this.padding,
    this.child,
    this.color = Colors.white,
    this.height,
  });

  final EdgeInsets? padding;
  final Widget? child;
  final Color color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 0.0,
            spreadRadius: 0.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}
