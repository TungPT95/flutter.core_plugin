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

  @override
  Widget build(BuildContext context) {
    return null;
  }

  double screenHeightFraction(double percent) {
    return screenSize.height * percent / 100;
  }

  void pushFoResult(String route, Request request) async {
    final result =
    await Navigator.pushNamed<dynamic>(context, route, arguments: request);
    if (result != null && result is Result) {
      onPopResult(request.requestCode, result.resultCode, result.bundleResult);
    }
  }

  void popForResult(Status status, {dynamic bundleResult}) {
    Navigator.pop<Result>(
        context, Result(resultCode: status, bundleResult: bundleResult));
  }

  void onPopResult(int requestCode, Status resultCode, dynamic resultBundle) {}
}

class Result {
  Status resultCode = Status.RESULT_CANCEL;
  dynamic bundleResult;

  Result({this.resultCode, this.bundleResult});
}

class Request {
  int requestCode;
  dynamic bundle;

  Request(this.requestCode, this.bundle);
}

enum Status { RESULT_CANCEL, RESULT_OK }
