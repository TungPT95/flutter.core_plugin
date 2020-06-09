import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

class ExVisibleDetector extends StatefulWidget {
  static Widget newInstance() => MaterialApp(
        home: ExVisibleDetector._(),
      );

  ExVisibleDetector._();

  @override
  _ExVisibleDetectorState createState() => new _ExVisibleDetectorState();
}

class _ExVisibleDetectorState extends BaseState<ExVisibleDetector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (_, index) {
          print('[TUNG] ===> $index');
          return Text(index.toString());
        },
        itemExtent: 70,
        itemCount: 100,
      ),
    );
  }
}
