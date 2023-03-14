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
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
          for (int i = 0; i < 3; i++)
            Column(
              children: [
                const _TransactionItem(
                  quantity: 1,
                  itemName: 'Shovel',
                  itemId: '#EASFEAD13486',
                  itemPrice: 99.0,
                ),
                i != 2 ? const SizedBox(height: 12) : Container(),
              ],
            ),
          const SizedBox(height: 7),
          Divider(height: 26, color: kNeutralColor.shade80, thickness: 1),
          Row(
            children: [
              Text(
                'x3',
                style: kTitleStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                'PHP 396.00',
                style: kTitleStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor.shade60,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    required this.itemName,
    required this.itemId,
    required this.quantity,
    required this.itemPrice,
    this.colorHex,
  });

  final String itemName;
  final String itemId;
  final int quantity;
  final double itemPrice;
  final String? colorHex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 15,
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.centerLeft,
            child: Text(
              'x$quantity',
              style: kLabelStyle.copyWith(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 25),
        CustomPaint(
          painter: colorHex == null ? _LinePainter() : null,
          child: Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: colorHex == null
                  ? Border.all(color: Colors.black, width: 0.5)
                  : null,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              itemName,
              style: kLabelStyle.copyWith(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              itemId,
              style: kLabelStyle.copyWith(
                fontWeight: FontWeight.normal,
                color: kNeutralColor.shade50,
              ),
            )
          ],
        ),
        const Spacer(),
        Text(
          'PHP ${(itemPrice * quantity).toStringAsFixed(2)}',
          style: kLabelStyle.copyWith(
            color: kPrimaryColor.shade60,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
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
