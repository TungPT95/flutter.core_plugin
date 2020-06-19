import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/widgets.dart';

Future<Bundle> push(PageIntent intent) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  assert(intent.screen.isNotNull);
  return Navigator.pushNamed<Bundle>(intent.context, intent.screen.toString(),
      arguments: intent);
}

Future<Bundle> pushReplacement(PageIntent intent, {Bundle resultBundle}) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  assert(intent.screen.isNotNull);
  return Navigator.pushReplacementNamed<dynamic, Bundle>(
      intent.context, intent.screen.toString(),
      result: resultBundle, arguments: intent);
}

void pop(PageIntent intent) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  if (Navigator.canPop(intent.context))
    Navigator.pop<Bundle>(intent.context, intent.bundle);
}

///push screen mới và pop các screen trước đó đến khi thoả điều kiện [predicate]
Future<Bundle> pushAndRemoveUntil(PageIntent intent, RoutePredicate predicate) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  assert(intent.screen.isNotNull);
  return Navigator.pushNamedAndRemoveUntil<Bundle>(
      intent.context, intent.screen.toString(), predicate,
      arguments: intent);
}

///push screen và pop đến khi gặp screen đầu tiên thì không pop nữa
Future<Bundle> pushToFirst(PageIntent intent) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  assert(intent.screen.isNotNull);
  return pushAndRemoveUntil(intent, (route) => route.isFirst);
}

///push screen mới lên top of stack
Future<Bundle> pushToTop(PageIntent intent) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  assert(intent.screen.isNotNull);
  return pushAndRemoveUntil(intent, (route) => false);
}

///pop screen đến khi gặp [intent.screen] thì ko pop nữa
void popUntilScreen(PageIntent intent) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  assert(intent.screen.isNotNull);
  popUntil(intent, ModalRoute.withName(intent.screen.toString()));
}

///pop screen đến khi gặp [intent.screen] thì ko pop nữa
///nếu [intent.screen] == null, thì sẽ pop tới trang đầu tiên
void popUntilScreenOrFirst(PageIntent intent) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  assert(intent.screen.isNotNull);
  Navigator.popUntil(intent.context, (route) {
    return '${intent.screen}' == route.settings.name || route.isFirst;
  });
}

///pop screen đến khi gặp [intent.screen] thì thoả điều kiện của [predicate] thì mới dừng pop
void popUntil(PageIntent intent, RoutePredicate predicate) {
  assert(intent.isNotNull);
  assert(intent.context.isNotNull);
  Navigator.popUntil(intent.context, predicate);
}
