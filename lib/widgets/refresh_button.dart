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
      child: SizedBox(
        height: 60.0,
        width: 60.0,
        child: RaisedButton(
          elevation: 4.0,
          onPressed: onPressed,
          padding: const EdgeInsets.all(0.0),
          shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(60.0)),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: begin,
                end: end,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.8),
                  Theme.of(context).accentColor.withOpacity(0.8),
                ],
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(60.0),
              ),
            ),
            child: Container(
              // min sizes for Material buttons
              alignment: Alignment.center,
              child: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
