import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get theme => Theme.of(context);

  Size get screenSize => MediaQuery.of(context).size;

  ///width of Iphone 5 device
  double _designWidth = 375.0;

  ///height of Iphone 5 device
  double _designHeight = 667.0;

  double scaleWidth(double width) {
    return width * screenSize.width / _designWidth;
  }

  double scaleHeight(double height) {
    return height * screenSize.height / _designHeight;
  }

  double screenWidthRatio() => screenSize.width / _designWidth;

  double screenHeightRatio() => screenSize.height / _designHeight;

  double screenWidthFraction(double percent) {
    return screenSize.width * percent / 100;
  }

  double screenHeightFraction(double percent) {
    return screenSize.height * percent / 100;
  }
}
