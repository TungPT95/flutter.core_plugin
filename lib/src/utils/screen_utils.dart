import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_state.dart';

class ScreenUtils {
  static Size screenSize(context) => MediaQuery.of(context).size;

  static ThemeData screenTheme(context) => Theme.of(context);

  static TextTheme textTheme(context) => screenTheme(context).textTheme;

  static double scaleWidth(BuildContext context, double width) {
    return width * screenSize(context).width / designWidth;
  }

  static double scaleHeight(BuildContext context, double height) {
    return height * screenSize(context).height / designHeight;
  }

  static double screenWidthRatio(BuildContext context) =>
      screenSize(context).width / designWidth;

  static double screenHeightRatio(BuildContext context) =>
      screenSize(context).height / designHeight;

  static double screenWidthFraction(BuildContext context, double percent) {
    return screenSize(context).width * percent / 100;
  }

  static double screenHeightFraction(BuildContext context, double percent) {
    return screenSize(context).height * percent / 100;
  }
}
