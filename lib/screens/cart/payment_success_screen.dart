import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/triangle_painter.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/screens/cart/checkout_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  static const id = '${CheckoutScreen.id}/success';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor.shade60,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: size.height / 4.25,
              width: size.width / 1.2,
              child: CustomPaint(
                painter: TrianglePainter(
                  color: kPrimaryColor.shade40,
                  xMultiplier: 1,
                  yMultiplier: 1,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: size.height / 4.25,
              width: size.width / 1.2,
              child: CustomPaint(
                painter: TrianglePainter(
                  color: kPrimaryColor.shade40,
                  xMultiplier: 1,
                  yMultiplier: 1,
                  startAtOrigin: false,
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Payment successful!',
                style: kHeadlineStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
