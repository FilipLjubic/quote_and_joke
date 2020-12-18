import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    this.onPressed,
    this.begin,
    this.end,
  });

  final Function onPressed;
  final Alignment begin;
  final Alignment end;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24.0,
      left: 24.0,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(begin: begin, end: end, colors: [
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).accentColor.withOpacity(0.8),
            ]),
          ),
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
