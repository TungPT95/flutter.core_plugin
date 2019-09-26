import 'package:flutter/material.dart';

import 'constants.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  ResponsiveLayout({this.desktop, this.tablet, this.mobile});

  @override
  _ResponsiveLayoutState createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        if (constraint.maxWidth < TABLET_WIDTH_MIN) {
          return widget.mobile ??
              Center(
                child: Text('no mobile screen'.toUpperCase()),
              );
        } else if (constraint.maxWidth >= TABLET_WIDTH_MIN &&
            constraint.maxWidth < DESKTOP_WIDTH_MIN) {
          return widget.tablet ??
              Center(
                child: Text('no tablet screen'.toUpperCase()),
              );
        } else {
          return widget.desktop ??
              Center(
                child: Text('no desktop screen'.toUpperCase()),
              );
        }
      }),
    );
  }
}
