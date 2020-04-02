import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/navigator/bundle.dart';
import 'package:core_plugin/src/navigator/page_intent.dart' as intent;
import 'package:flutter/widgets.dart';

export 'bundle.dart';
export 'page_intent.dart';
export 'routing.dart';

Future<Bundle> push(intent.PageIntent intent) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  assert(intent.screen.isNotNull);
  return Navigator.pushNamed<Bundle>(intent.context, intent.screen.toString(),
      arguments: intent.bundle);
}

Future<Bundle> pushReplacement(intent.PageIntent intent,
    {Bundle resultBundle}) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  assert(intent.screen.isNotNull);
  return Navigator.pushReplacementNamed<dynamic, Bundle>(
      intent.context, intent.screen.toString(),
      result: resultBundle, arguments: intent.bundle);
}

bool pop(intent.PageIntent intent) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  if (Navigator.canPop(intent.context))
    return Navigator.pop<Bundle>(intent.context, intent.bundle);
  return false;
}

Future<Bundle> pushAndRemoveUntil(
    intent.PageIntent intent, bool Function(Route<dynamic> route) predicate,
    {Bundle resultBundle}) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  assert(intent.screen.isNotNull);
  return Navigator.pushNamedAndRemoveUntil<Bundle>(
      intent.context, intent.screen.toString(), predicate,
      arguments: intent.bundle);
}

Future<Bundle> pushToFirst(intent.PageIntent intent, {Bundle resultBundle}) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  assert(intent.screen.isNotNull);
  return pushAndRemoveUntil(intent, (route) => route.isFirst,
      resultBundle: intent.bundle);
}
