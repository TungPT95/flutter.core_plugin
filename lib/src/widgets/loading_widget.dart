import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool isError;
  final void Function() onRetry;

  LoadingWidget(
      {this.child, this.isLoading = false, this.isError = false, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          )
        : isError ? ErrorWidget(onRetry: onRetry) : child;
  }
}

class ErrorWidget extends StatelessWidget {
  final void Function() onRetry;
  final String reloadTitle;
  final Color buttonColor;
  final Color buttonTextColor;

  ErrorWidget(
      {this.onRetry,
      this.reloadTitle,
      this.buttonColor = Colors.blue,
      this.buttonTextColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, bottom: 8),
            child: Image.asset(
              'assets/error.png',
              package: 'core_plugin',
              width: ScreenUtils.scaleWidth(context, 64),
              height: ScreenUtils.scaleHeight(context, 64),
            ),
          ),
          SizedBox(
            height: ScreenUtils.scaleHeight(context, 42),
            width: ScreenUtils.scaleHeight(context, 100),
            child: RaisedButton(
              onPressed: onRetry,
              color: buttonColor,
              child: Text(
                isNullOrEmptyString(reloadTitle) ? 'Thử lại' : reloadTitle,
                style: TextStyle(color: buttonTextColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
