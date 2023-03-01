import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/cart_item.dart';
import 'package:toolmart/components/sticky_button.dart';
import 'package:toolmart/components/toolmart_back_button.dart';
import 'package:toolmart/components/toolmart_radio_button.dart';
import 'package:toolmart/components/toolmart_textfield.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/screens/cart/cart_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  static const id = '${CartScreen.id}/checkout';

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const StickyButton(text: 'Pay'),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: topPadding + 25),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 32),
                    ToolMartBackButton(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                          color: Colors.black.withAlpha((2 / 25 * 255).floor()),
                        )
                      ],
                    ),
                    const SizedBox(width: 25),
                    Text(
                      'Checkout',
                      style: kHeadlineStyle.copyWith(
                        color: kPrimaryColor.shade60,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
            SliverList(
              delegate: SliverChildListDelegate([
                for (int i = 0; i < 4; i++)
                  Column(
                    children: [
                      const CartItem(),
                      i < 3 ? const SizedBox(height: 12) : Container(),
                    ],
                  ),
              ]),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 35)),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: _MethodOfPayment(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class _MethodOfPayment extends StatefulWidget {
  const _MethodOfPayment();

  @override
  State<_MethodOfPayment> createState() => _MethodOfPaymentState();
}

class _MethodOfPaymentState extends State<_MethodOfPayment> {
  int activeMethod = 0;
  int activeBank = 0;

  void _onMethodTap(int index) {
    setState(() {
      activeMethod = index;
    });
  }

  void _onBankTap(int index) {
    setState(() {
      activeBank = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Method of Payment',
          style: kTitleStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: kNeutralColor.shade30,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            _PaymentMethod(
              method: 'Cash on Delivery',
              isSelected: activeMethod == 0,
              onTap: () => _onMethodTap(0),
            ),
            const SizedBox(width: 20),
            _PaymentMethod(
              method: 'Bank',
              isSelected: activeMethod == 1,
              onTap: () => _onMethodTap(1),
            ),
            const SizedBox(width: 20),
            _PaymentMethod(
              method: 'GCash',
              isSelected: activeMethod == 2,
              onTap: () => _onMethodTap(2),
            ),
          ],
        ),
        const SizedBox(height: 30),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: activeMethod == 1
              ? _BankSection(
                  activeBank: activeBank,
                  onBankTap: _onBankTap,
                )
              : Container(key: UniqueKey()),
        ),
      ],
    );
  }
}

class _BankSection extends StatelessWidget {
  const _BankSection({
    required this.activeBank,
    required this.onBankTap,
  });

  final int activeBank;
  final Function(int) onBankTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _BankButton(
                  assetPath: 'assets/illustrations/card-bancontact.svg',
                  isSelected: activeBank == 0,
                  onTap: () => onBankTap(0),
                ),
                const SizedBox(height: 12),
                _BankButton(
                  assetPath: 'assets/illustrations/card-mastercard.svg',
                  isSelected: activeBank == 3,
                  onTap: () => onBankTap(3),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _BankButton(
                  assetPath: 'assets/illustrations/card-amex.svg',
                  // isImage: true,
                  isSelected: activeBank == 1,
                  onTap: () => onBankTap(1),
                ),
                const SizedBox(height: 12),
                _BankButton(
                  assetPath: 'assets/illustrations/card-paypal.svg',
                  isSelected: activeBank == 4,
                  onTap: () => onBankTap(4),
                ),
              ],
            ),
            _BankButton(
              assetPath: 'assets/illustrations/card-visa.svg',
              isSelected: activeBank == 2,
              onTap: () => onBankTap(2),
            ),
          ],
        ),
        const SizedBox(height: 30),
        const ToolMartTextfield(hintText: 'Cardholder name'),
        const SizedBox(height: 12),
        const ToolMartTextfield(hintText: 'Card number', digitsOnly: true),
        const SizedBox(height: 12),
        Row(
          children: const [
            Expanded(
              child: ToolMartTextfield(
                hintText: 'Expiration date',
                dateTimeOnly: true,
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              child: ToolMartTextfield(
                hintText: 'Security code',
                digitsOnly: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const ToolMartCheckboxButton(isSelected: true),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                  style: kBodyStyle.copyWith(
                    color: kPrimaryColor.shade60,
                  ),
                  children: [
                    const TextSpan(text: 'I agree to the '),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: kBodyStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: kSecondaryColor.shade40,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ]),
            )
          ],
        )
      ],
    );
  }
}

class ToolMartCheckboxButton extends StatelessWidget {
  const ToolMartCheckboxButton({
    super.key,
    this.size = 17,
    this.isSelected = false,
    this.onTap,
  });

  final double size;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 3.3),
          border: Border.all(color: kPrimaryColor.shade60, width: 1),
        ),
        child: Container(
          height: size / 2,
          width: size / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size / 8.5),
            color: isSelected ? kPrimaryColor.shade60 : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class _BankButton extends StatelessWidget {
  const _BankButton({
    this.isSelected = false,
    this.onTap,
    required this.assetPath,
  });

  final bool isSelected;
  final VoidCallback? onTap;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? kPrimaryColor.shade60
                : Colors.black.withAlpha((1 / 10 * 255).floor()),
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: SvgPicture.asset(assetPath),
      ),
    );
  }
}

class _PaymentMethod extends StatelessWidget {
  const _PaymentMethod({
    required this.method,
    this.isSelected = false,
    this.onTap,
  });

  final String method;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToolMartRadioButton(isSelected: isSelected),
          const SizedBox(width: 5),
          Text(
            method,
            style: kBodyStyle.copyWith(
              color: kPrimaryColor.shade60,
            ),
          )
        ],
      ),
    );
  }
}
