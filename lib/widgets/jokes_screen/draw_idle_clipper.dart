import 'dart:math' as math;

import 'package:flutter/material.dart';

class DrawIdleClipper extends CustomClipper<Path> {
  DrawIdleClipper(this.value);
  var value;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.85);

    final ctrlPoint = Offset(
      size.width * 0.2 + (size.width * 0.07) * math.cos(value * math.pi),
      size.height + 10 * math.sin(value * math.pi),
    );

    path.quadraticBezierTo(
        ctrlPoint.dx, ctrlPoint.dy, size.width * 0.5, size.height * 0.92);

    final ctrlPoint2 = Offset(
      size.width * 0.9 - (size.width * 0.05) * math.cos(value * math.pi),
      size.height * 0.8 - 10 * math.sin(value * math.pi),
    );

    path.quadraticBezierTo(
        ctrlPoint2.dx, ctrlPoint2.dy, size.width, size.height * 0.87);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
