import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/navigator/bundle.dart';
import 'package:core_plugin/src/navigator/navigator.dart';
import 'package:core_plugin/src/navigator/page_intent.dart';
import 'package:flutter/material.dart';

///width of Iphone 5 device
const double designWidth = 375.0;

///height of Iphone 5 device
const double designHeight = 667.0;

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  Bundle get bundle {
    try {
      return context.read<Bundle>();
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

  void pushScreen(PageIntent intent) async {
    final result = await context.push(intent);
    //todo chỉ gọi [onPopResult] khi result != null và phải là Bundle class
    if (result != null && result is Bundle) {
      onPopResult(intent.screen, result);
    }
  }

  ///[resultBundle] result trả về cho screen trước đó, khi replace screen hiện tại bởi screen khác
  /// vd: screen1 [pushScreen] => screen2
  /// screen2 [pushReplacementScreen] bởi screen3, thì resultBundle ở đây sẽ return cho screen1
  void pushReplacementScreen(PageIntent intent, {Bundle resultBundle}) async {
    final result =
        await context.pushReplacement(intent, resultBundle: resultBundle);
    //todo chỉ gọi [onPopResult] khi result != null và phải là Bundle class
    if (result != null && result is Bundle) {
      onPopResult(intent.screen, result);
    }
  }

  ///[resultBundle] kết quả trả về khi pop screen
  void popScreen({Bundle resultBundle}) {
    context.pop(resultBundle: resultBundle);
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.scaleWidth(6))),
          content: Text(
            content,
            textScaleFactor: context.screenWidthRatio,
          ),
          contentPadding:
              EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
          actions: [
            if (isNotNullString(negativeTitle))
              FlatButton(
                onPressed: onNegativeClick,
                child: Text(
                  negativeTitle,
                  textScaleFactor: context.screenWidthRatio,
                ),
              ),
            if (isNotNullString(positiveTitle))
              FlatButton(
                onPressed: onPositiveClick,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.scaleWidth(6))),
                child: Text(
                  positiveTitle,
                  textScaleFactor: context.screenWidthRatio,
                ),
              ),
          ],
        ));
  }

  /// phải truyền context b1ởi vì có những trường hợp ko phải context của Scaffold
  showSnackBar(BuildContext context, String message,
      {TextAlign textAlign, SnackBarBehavior behavior}) {
    Scaffold.of(context)
        .hideCurrentSnackBar(reason: SnackBarClosedReason.remove);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message ?? '',
        textAlign: textAlign,
        textScaleFactor: context.screenWidthRatio,
      ),
      duration: Duration(milliseconds: 1500),
      behavior: behavior,
      shape: behavior == SnackBarBehavior.floating
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
          : null,
    ));
  }

  ///[duration] is second
  showToast(context, String message, {int duration = 1}) {
    Toast.show(message, context, duration: duration);
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
