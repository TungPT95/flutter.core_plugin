import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/navigator/bundle.dart';
import 'package:core_plugin/src/navigator/intent.dart' as intent;
import 'package:core_plugin/src/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///width of Iphone 5 device
const double designWidth = 375.0;

///height of Iphone 5 device
const double designHeight = 667.0;

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get theme => Theme.of(context);

  Size get screenSize => MediaQuery.of(context).size;

  double scaleWidth(double width) => width * screenSize.width / designWidth;

  double scaleHeight(double height) =>
      height * screenSize.height / designHeight;

  double screenWidthRatio() => screenSize.width / designWidth;

  double screenHeightRatio() => screenSize.height / designHeight;

  double screenWidthFraction(double percent) =>
      screenSize.width * percent / 100;

  double screenHeightFraction(double percent) =>
      screenSize.height * percent / 100;

  Bundle get bundle {
    try {
      return Provider.of<Bundle>(context, listen: false);
    } catch (e, s) {
      print(s);
    }
    return null;
  }

  Widget buildContent(Widget content) {
    assert(content != null);
    return WillPopScope(
      onWillPop: onBackPress,
      child: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void pushScreen(intent.Intent intent) async {
    final result = await push(intent);
    //todo chỉ gọi [onPopResult] khi result != null và phải là Bundle class
    if (result != null && result is Bundle) {
      onPopResult(intent.screen, result);
    }
  }

  ///[resultBundle] result trả về cho screen trước đó, khi replace screen hiện tại bởi screen khác
  /// vd: screen1 [pushScreen] => screen2
  /// screen2 [pushReplacementScreen] bởi screen3, thì resultBundle ở đây sẽ return cho screen1
  void pushReplacementScreen(intent.Intent intent,
      {Bundle resultBundle}) async {
    final result = await pushReplacement(intent, resultBundle);
    //todo chỉ gọi [onPopResult] khi result != null và phải là Bundle class
    if (result != null && result is Bundle) {
      onPopResult(intent.screen, result);
    }
  }

  ///[resultBundle] kết quả trả về khi pop screen
  void popScreen({Bundle resultBundle}) {
    pop(intent.Intent(context, null, bundle: resultBundle));
  }

  ///[returnScreen] Type của page vừa đc push, sẽ return về result [resultBundle] từ page đó
  void onPopResult(Type returnScreen, Bundle resultBundle) {}

  void onBackPress() {
    popScreen();
  }

  void showAlertDialog({
    bool isCancelable = true,
    String content = '',
    String positiveTitle,
    void Function() onPositiveClick,
    String negativeTitle,
    void Function() onNegativeClick,
  }) {
    showDialog(
        context: context,
        barrierDismissible: isCancelable,
        child: AlertDialog(
          content: Text(
            content,
            textScaleFactor: screenWidthRatio(),
          ),
          contentPadding:
              EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
          actions: [
            if (isNotNullString(negativeTitle))
              FlatButton(
                onPressed: onNegativeClick,
                child: Text(
                  negativeTitle,
                  textScaleFactor: screenWidthRatio(),
                ),
              ),
            if (isNotNullString(positiveTitle))
              FlatButton(
                onPressed: onPositiveClick,
                child: Text(
                  positiveTitle,
                  textScaleFactor: screenWidthRatio(),
                ),
              ),
          ],
        ));
  }

  /// phải truyền context b1ởi vì có những trường hợp ko phải context của Scaffold
  showSnackBar(context, String message) {
    Scaffold.of(context)
        .hideCurrentSnackBar(reason: SnackBarClosedReason.remove);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ));
  }
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
