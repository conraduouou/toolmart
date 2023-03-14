import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/error_dialog.dart';
import 'package:toolmart/components/on_tap_wrapper.dart';
import 'package:toolmart/components/toolmart_back_button.dart';
import 'package:toolmart/components/toolmart_cart_item.dart';
import 'package:toolmart/components/toolmart_radio_button.dart';
import 'package:toolmart/components/toolmart_sticky_button.dart';
import 'package:toolmart/components/toolmart_textfield.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/models/core/cart_item.dart';
import 'package:toolmart/models/core/transaction.dart';
import 'package:toolmart/providers/cart/checkout_screen_provider.dart';
import 'package:toolmart/screens/cart/cart_screen.dart';
import 'package:toolmart/screens/cart/payment_success_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
    required this.cartItems,
  });

  static const id = '${CartScreen.id}/checkout';
  final List<CartItem> cartItems;

  Future<void> _showDialog(
    BuildContext context, {
    String? title,
    String? message,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) => CustomDialog(title: title, message: message),
    );
  }

  Future<void> _pay(
    BuildContext context,
    CheckoutScreenProvider provider,
  ) async {
    final navigator = Navigator.of(context);
    final result = await provider.postTransaction();

    if (result is! Transaction) {
      // ignore: use_build_context_synchronously
      return _showDialog(
        context,
        title: 'Error',
        message: provider.errorMessage,
      );
    }

    navigator.pushNamed(PaymentSuccessScreen.id, arguments: result);
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = cartItems.fold<double>(0.0, (p, e) => p + e.price!);
    final totalItems = cartItems.fold<int>(0, (p, e) => p + e.itemQuantity!);
    final topPadding = MediaQuery.of(context).viewPadding.top;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ChangeNotifierProvider(
        create: (_) => CheckoutScreenProvider(cartItems),
        builder: (context, child) {
          final provider = context.watch<CheckoutScreenProvider>();

          return Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: ToolMartStickyButton(
              text:
                  'Pay (PHP ${totalPrice.toStringAsFixed(2)} - ${totalItems}x)',
              onTap: () async => await _pay(context, provider),
            ),
            body: child!,
          );
        },
        child: CustomScrollView(
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
            SliverFixedExtentList(
              itemExtent: ToolMartCartItem.height + 12,
              delegate: SliverChildListDelegate([
                for (int i = 0; i < cartItems.length; i++)
                  Column(
                    children: [
                      ToolMartCartItem(
                        cartItem: cartItems[i],
                        enableControls: false,
                      ),
                      const SizedBox(height: 12),
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

class _MethodOfPayment extends StatelessWidget {
  const _MethodOfPayment();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CheckoutScreenProvider>();
    final activeMethod = context
        .select<CheckoutScreenProvider, PaymentMethod>((p) => p.paymentMethod);

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
              isSelected: activeMethod == PaymentMethod.cod,
              onTap: () => provider.paymentMethod = PaymentMethod.cod,
            ),
            const SizedBox(width: 20),
            _PaymentMethod(
              method: 'Bank',
              isSelected: activeMethod == PaymentMethod.bank,
              onTap: () => provider.paymentMethod = PaymentMethod.bank,
            ),
            const SizedBox(width: 20),
            _PaymentMethod(
              method: 'GCash',
              isSelected: activeMethod == PaymentMethod.gcash,
              onTap: () => provider.paymentMethod = PaymentMethod.gcash,
            ),
          ],
        ),
        const SizedBox(height: 30),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: activeMethod == PaymentMethod.bank
              ? const _BankSection()
              : Container(key: UniqueKey()),
        ),
      ],
    );
  }
}

class _BankSection extends StatelessWidget {
  const _BankSection();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CheckoutScreenProvider>();
    final activeBank =
        context.select<CheckoutScreenProvider, int>((p) => p.bank);

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
                  onTap: () => provider.bank = 0,
                ),
                const SizedBox(height: 12),
                _BankButton(
                  assetPath: 'assets/illustrations/card-mastercard.svg',
                  isSelected: activeBank == 3,
                  onTap: () => provider.bank = 3,
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
                  onTap: () => provider.bank = 1,
                ),
                const SizedBox(height: 12),
                _BankButton(
                  assetPath: 'assets/illustrations/card-paypal.svg',
                  isSelected: activeBank == 4,
                  onTap: () => provider.bank = 4,
                ),
              ],
            ),
            _BankButton(
              assetPath: 'assets/illustrations/card-visa.svg',
              isSelected: activeBank == 2,
              onTap: () => provider.bank = 2,
            ),
          ],
        ),
        const SizedBox(height: 30),
        ToolMartTextfield(
          hintText: 'Cardholder name',
          initialText: provider.userName,
          onChanged: (s) => provider.userName = s,
        ),
        const SizedBox(height: 12),
        ToolMartTextfield(
          hintText: 'Card number',
          digitsOnly: true,
          initialText: provider.cardNumber,
          onChanged: (s) => provider.cardNumber = s,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ToolMartTextfield(
                hintText: 'Expiration date',
                dateTimeOnly: true,
                maxLength: 5,
                initialText: provider.expirationDate,
                onChanged: (s) => provider.expirationDate = s,
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: ToolMartTextfield(
                hintText: 'Security code',
                digitsOnly: true,
                maxLength: 3,
                initialText: provider.securityCode,
                onChanged: (s) => provider.securityCode = s,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const _TermsAndConditions()
      ],
    );
  }
}

class _TermsAndConditions extends StatelessWidget {
  const _TermsAndConditions();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CheckoutScreenProvider>();
    final isAgreed =
        context.select<CheckoutScreenProvider, bool>((p) => p.isAgreed);

    return OnTapWrapper(
      onTap: () => provider.isAgreed = !provider.isAgreed,
      child: Row(
        children: [
          ToolMartCheckboxButton(isSelected: isAgreed),
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
      ),
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
