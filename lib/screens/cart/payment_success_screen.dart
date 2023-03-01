import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_button.dart';
import 'package:toolmart/components/triangle_painter.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/screens/cart/checkout_screen.dart';
import 'package:toolmart/screens/home/home_screen.dart';

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
              SvgPicture.asset('assets/illustrations/payment-1.svg'),
              const SizedBox(height: 20),
              Text(
                'Payment successful!',
                style: kHeadlineStyle.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: size.width - 40,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: kTitleStyle.copyWith(color: Colors.white),
                    children: [
                      const TextSpan(text: 'Transaction '),
                      TextSpan(
                        text: 'E12-001 ',
                        style: kTitleStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: 'was successfully processed.'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height / 9.5),
              ToolMartButton(
                text: 'Go to Home',
                color: Colors.white,
                textColor: kPrimaryColor.shade60,
                fontWeight: FontWeight.bold,
                width: 224,
                onTap: () => Navigator.of(context)
                    .popUntil(ModalRoute.withName(HomeScreen.id)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
