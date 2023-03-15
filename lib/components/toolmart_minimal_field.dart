import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toolmart/color_schemes.g.dart';
import 'package:toolmart/constants.dart';

class ToolMartMinimalField extends StatefulWidget {
  const ToolMartMinimalField({
    super.key,
    this.focusNode,
    this.height,
    this.width,
    this.onChanged,
    this.hintText,
    this.onSendTap,
  });

  final FocusNode? focusNode;
  final double? height;
  final double? width;
  final void Function(String)? onChanged;
  final String? hintText;
  final VoidCallback? onSendTap;

  @override
  State<ToolMartMinimalField> createState() => _ToolMartMinimalFieldState();
}

class _ToolMartMinimalFieldState extends State<ToolMartMinimalField> {
  static const _height = 51.0;

  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
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
            child: Container(
              height: widget.height ?? _height,
              width: widget.width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      cursorColor: kNeutralColor.shade20,
                      onChanged: widget.onChanged,
                      style: kBodyStyle.copyWith(
                        color: kNeutralColor.shade10,
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: widget.hintText,
                        hintStyle: kBodyStyle.copyWith(
                          color: kNeutralColor.shade60,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _SendButton(onTap: widget.onSendTap),
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
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: kNeutralColor.shade20,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({
    this.onTap,
  });

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
        'assets/icons/ic-send.svg',
      ),
    );
  }
}
