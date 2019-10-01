import 'package:flutter/material.dart';

///width of Iphone 5 device
const double designWidth = 375.0;

///height of Iphone 5 device
const double designHeight = 667.0;

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get theme => Theme.of(context);

  Size get screenSize => MediaQuery.of(context).size;


  double scaleWidth(double width) {
    return width * screenSize.width / designWidth;
  }

  double scaleHeight(double height) {
    return height * screenSize.height / designHeight;
  }

  double screenWidthRatio() => screenSize.width / designWidth;

  double screenHeightRatio() => screenSize.height / designHeight;

  double screenWidthFraction(double percent) {
    return screenSize.width * percent / 100;
  }

  double screenHeightFraction(double percent) {
    return screenSize.height * percent / 100;
  }
}
