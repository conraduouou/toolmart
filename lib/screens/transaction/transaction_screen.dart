import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_back_button.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/screens/user/user_screen.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  static const id = '${UserScreen.id}/transaction';

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: topPadding + 25),
              Row(
                children: [
                  const SizedBox(width: 12),
                  const ToolMartBackButton(),
                  const SizedBox(width: 25),
                  Text(
                    'E12-001',
                    style: kHeadlineStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor.shade60,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 80),
              const _TransactionDetails(),
              const SizedBox(height: 75),
              const _TransactionItems(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionItems extends StatelessWidget {
  const _TransactionItems();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Items',
            style: kTitleStyle.copyWith(
              color: kNeutralColor.shade30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'x1',
                style: kLabelStyle.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 25),
              CustomPaint(
                painter: _LinePainter(),
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Shovel',
                    style: kLabelStyle.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '#EASFEAD13486',
                    style: kLabelStyle.copyWith(
                      fontWeight: FontWeight.normal,
                      color: kNeutralColor.shade50,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Text(
                'PHP 99.00',
                style: kLabelStyle.copyWith(
                  color: kPrimaryColor.shade60,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kErrorColor.shade50
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawLine(Offset(0, size.height), Offset(size.height, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TransactionDetails extends StatelessWidget {
  const _TransactionDetails();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          _TransactionDetail(
            heading: 'Transaction Date',
            detail: 'February 28, 2023',
          ),
          SizedBox(height: 35),
          _TransactionDetail(
            heading: 'Method of payment',
            detail: 'Bank (VISA)',
          ),
        ],
      ),
    );
  }
}

class _TransactionDetail extends StatelessWidget {
  const _TransactionDetail({
    required this.heading,
    required this.detail,
  });

  final String heading;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          heading,
          style: kTitleStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: kNeutralColor.shade30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          detail,
          style: kBodyStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: kPrimaryColor.shade60,
          ),
        ),
      ],
    );
  }
}
