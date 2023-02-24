import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/components/toolmart_button.dart';
import 'package:toolmart/components/toolmart_textfield.dart';
import 'package:toolmart/constants.dart';

class LoginElements extends StatelessWidget {
  const LoginElements({super.key});

  @override
  Widget build(BuildContext context) {
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
          const ToolMartTextfield(hintText: 'Email'),
          const SizedBox(height: 12),
          const ToolMartTextfield(
            hintText: 'Password',
            fieldType: ToolMartFieldType.password,
          ),
          const SizedBox(height: 42),
          ToolMartButton.primary(
            text: 'Login',
            width: 224,
          ),
          const SizedBox(height: 23),
          ToolMartButton.secondary(
            text: 'Forgot Password',
            width: 224,
          ),
        ],
      ),
    );
  }
}
