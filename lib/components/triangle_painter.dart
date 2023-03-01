import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  const TrianglePainter({
    required this.color,
    this.yMultiplier,
    this.xMultiplier,
    this.startAtOrigin = true,
  });

  final Color color;

  /// A value between 0 and 1 that will be multiplied to the width of the canvas.
  final double? xMultiplier;

  /// A value between 0 and 1 that will be multiplied to the height of the canvas.
  final double? yMultiplier;

  /// Determines whether to start at point (0, 0) or at (width, height).
  final bool startAtOrigin;

  static const _defaultX = 0.85;
  static const _defaultY = 0.82;

  @override
  void paint(Canvas canvas, Size size) {
    final x = size.width * (xMultiplier ?? _defaultX);
    final y = size.height * (yMultiplier ?? _defaultY);

    final painter = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    if (startAtOrigin) {
      path
        ..moveTo(0, y)
        ..lineTo(x, 0)
        ..lineTo(0, 0)
        ..lineTo(0, y)
        ..close();
    } else {
      path
        ..moveTo(size.width - x, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width, size.height - y)
        ..lineTo(size.width - x, size.height)
        ..close();
    }

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
