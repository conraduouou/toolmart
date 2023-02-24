import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/constants.dart';

enum ToolMartFieldType {
  normal,
  password,
}

class ToolMartTextfield extends StatefulWidget {
  const ToolMartTextfield({
    super.key,
    this.height,
    this.width,
    this.onChanged,
    this.digitsOnly = false,
    this.dateTimeOnly = false,
    this.hintText,
    this.fieldType,
    this.focusNode,
  });

  final double? height;
  final double? width;
  final Function(String)? onChanged;
  final bool digitsOnly;
  final bool dateTimeOnly;
  final String? hintText;
  final ToolMartFieldType? fieldType;
  final FocusNode? focusNode;

  @override
  State<ToolMartTextfield> createState() => _ToolMartTextfieldState();
}

class _ToolMartTextfieldState extends State<ToolMartTextfield> {
  static const _height = 51.0;

  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late bool _isObscured;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _isObscured = widget.fieldType == ToolMartFieldType.password;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Focus(
          onFocusChange: (focused) =>
              focused ? _focusNode.requestFocus() : _focusNode.unfocus(),
          child: InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _focusNode.requestFocus(),
            child: SizedBox(
              height: widget.height ?? _height,
              width: widget.width,
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      obscureText: _isObscured,
                      cursorColor: kNeutralVariant.shade80,
                      onChanged: widget.onChanged,
                      keyboardType: widget.digitsOnly
                          ? TextInputType.number
                          : widget.dateTimeOnly
                              ? TextInputType.datetime
                              : null,
                      inputFormatters: widget.digitsOnly || widget.dateTimeOnly
                          ? [FilteringTextInputFormatter.digitsOnly]
                          : null,
                      style: kBodyStyle.copyWith(
                        color: kNeutralVariant.shade60,
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: widget.hintText,
                        hintStyle: kBodyStyle.copyWith(
                          color: kNeutralVariant.shade80,
                        ),
                      ),
                    ),
                  ),
                  widget.fieldType == ToolMartFieldType.password
                      ? const SizedBox(width: 8)
                      : Container(),
                  widget.fieldType == ToolMartFieldType.password
                      ? _ViewPasswordButton(
                          onTap: () =>
                              setState(() => _isObscured = !_isObscured),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: Container(
            height: widget.height ?? _height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kNeutralVariant.shade80, width: 2),
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}

class _ViewPasswordButton extends StatelessWidget {
  const _ViewPasswordButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: SvgPicture.asset(
        'assets/icons/ic-password-view.svg',
        colorFilter: ColorFilter.mode(
          kNeutralVariant.shade80,
          BlendMode.color,
        ),
      ),
    );
  }
}
