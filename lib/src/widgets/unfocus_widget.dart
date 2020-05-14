import 'package:flutter/material.dart';

class UnFocusWidget extends StatelessWidget {
  final Widget child;

  UnFocusWidget({this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        primaryFocus.unfocus();
      },
      child: child ?? Container(),
    );
  }
}
