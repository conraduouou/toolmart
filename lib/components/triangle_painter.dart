import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  const TrianglePainter({
    required this.color,
    this.yCor,
    this.xCor,
  });

  final Color color;
  final double? yCor;
  final double? xCor;

  @override
  void paint(Canvas canvas, Size size) {
    final x = xCor ?? size.width / 8.5;
    final y = yCor ?? size.height / 4.5;

    final painter = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(x, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, y)
      ..lineTo(x, size.height)
      ..close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
