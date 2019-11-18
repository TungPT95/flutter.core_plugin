import 'package:core_plugin/src/base_state.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ResponsiveWidget extends StatefulWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  ResponsiveWidget({this.desktop, this.tablet, this.mobile});

  @override
  _ResponsiveWidgetState createState() => _ResponsiveWidgetState();
}

class _ResponsiveWidgetState extends BaseState<ResponsiveWidget> {
  @override
  Widget build(BuildContext context) {
    return buildContent(LayoutBuilder(builder: (context, constraint) {
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
    }));
  }
}
