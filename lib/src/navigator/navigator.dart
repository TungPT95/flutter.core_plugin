import 'package:core_plugin/src/navigator/bundle.dart';
import 'package:core_plugin/src/navigator/intent.dart' as intent;
import 'package:flutter/widgets.dart';

export 'bundle.dart';
export 'intent.dart';
export 'routing.dart';

Future<Bundle> push(intent.Intent intent) {
  return Navigator.pushNamed<Bundle>(intent.context, intent.screen.toString(),
      arguments: intent.bundle);
}

Future<Bundle> pushReplacement(intent.Intent intent, Bundle resultBundle) {
  return Navigator.pushReplacementNamed<dynamic, Bundle>(
      intent.context, intent.screen.toString(),
      result: resultBundle, arguments: intent.bundle);
}

bool pop(intent.Intent intent) {
  return Navigator.pop<Bundle>(intent.context, intent.bundle);
}