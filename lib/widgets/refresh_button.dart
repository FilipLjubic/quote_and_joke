import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24.0,
      right: 24.0,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      ),
    );
  }
}
