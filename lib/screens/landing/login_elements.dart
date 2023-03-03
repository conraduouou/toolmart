import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/error_dialog.dart';
import 'package:toolmart/components/toolmart_button.dart';
import 'package:toolmart/components/toolmart_textfield.dart';
import 'package:toolmart/constants.dart';
import 'package:toolmart/providers/landing/landing_provider.dart';
import 'package:toolmart/screens/home/home_screen.dart';

class LoginElements extends StatelessWidget {
  const LoginElements({super.key});

  Future<void> _showDialog(BuildContext context, String? message) async {
    return await showDialog(
      context: context,
      builder: (context) => ErrorDialog(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LandingProvider>();

    if (provider.inAsync) {
      return CircularProgressIndicator(color: kPrimaryColor.shade60);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/illustrations/logo.svg'),
          const SizedBox(height: 10),
          Text(
            'ToolMart',
            style: kHeadlineStyle.copyWith(
              color: kSecondaryColor.shade50,
            ),
          ),
          const SizedBox(height: 55),
          ToolMartTextfield(
            hintText: 'Email',
            initialText: provider.email,
            onChanged: provider.emailOnChanged,
          ),
          const SizedBox(height: 12),
          ToolMartTextfield(
            hintText: 'Password',
            initialText: provider.password,
            fieldType: ToolMartFieldType.password,
            onChanged: provider.passwordOnChanged,
          ),
          const SizedBox(height: 42),
          ToolMartButton.primary(
            text: 'Login',
            width: 224,
            onTap: () async {
              final navigator = Navigator.of(context);
              final isSuccessful = await provider.login();

              if (!isSuccessful) {
                // ignore: use_build_context_synchronously
                await _showDialog(context, provider.errorMessage);
                return;
              }

              navigator.pushNamed(HomeScreen.id);
            },
          ),
          const SizedBox(height: 23),
          ToolMartButton.secondary(
            text: 'Forgot Password',
            width: 224,
            onTap: () async {},
          ),
        ],
      ),
    );
  }
}
