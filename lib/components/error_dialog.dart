import 'package:flutter/material.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/constants.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Error!',
              style: kHeadlineStyle.copyWith(
                color: kPrimaryColor.shade50,
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: Text(
                message ?? 'There was an error in making this request.',
                textAlign: TextAlign.center,
                style: kBodyStyle.copyWith(
                  color: kPrimaryColor.shade30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
