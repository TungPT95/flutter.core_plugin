import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/widgets.dart';

extension NavigatorBuildContextExtension on BuildContext {
  Future<Bundle> push(PageIntent intent, {bool rootNavigator}) {
    assert(intent.isNotNull);
    assert(intent.screen.isNotNull);
    return Navigator.of(this, rootNavigator: rootNavigator ?? false)
        .pushNamed<Bundle>(intent.screen.toString(), arguments: intent);
  }

  ///replace screen hiện tại bởi [intent.screen]
  Future<Bundle> pushReplacement(PageIntent intent,
      {Bundle resultBundle, bool rootNavigator}) {
    assert(intent.isNotNull);
    assert(intent.screen.isNotNull);
    return Navigator.of(this, rootNavigator: rootNavigator ?? false)
        .pushReplacementNamed<dynamic, Bundle>(intent.screen.toString(),
            result: resultBundle, arguments: intent);
  }

  void pop({Bundle resultBundle, bool rootNavigator}) {
    if (Navigator.of(this, rootNavigator: rootNavigator ?? false).canPop())
      Navigator.of(this, rootNavigator: rootNavigator ?? false)
          .pop<Bundle>(resultBundle);
  }

  ///push screen mới và pop các screen trước đó nếu thoả điều kiện [predicate]
  Future<Bundle> pushAndRemoveUntil(PageIntent intent, RoutePredicate predicate,
      {bool rootNavigator}) {
    assert(intent.isNotNull);
    assert(intent.screen.isNotNull);
    return Navigator.of(this, rootNavigator: rootNavigator ?? false)
        .pushNamedAndRemoveUntil<Bundle>(intent.screen.toString(), predicate,
            arguments: intent);
  }

  ///push screen và pop đến khi gặp screen đầu tiên thì không pop nữa
  Future<Bundle> pushToFirst(PageIntent intent, {bool rootNavigator}) {
    assert(intent.isNotNull);
    assert(intent.screen.isNotNull);
    return pushAndRemoveUntil(intent, (route) => route.isFirst,
        rootNavigator: rootNavigator);
  }

  ///push screen mới lên top of stack và clear tất cả những screen bên dưới nó
  Future<Bundle> pushToTop(PageIntent intent, {bool rootNavigator}) {
    assert(intent.isNotNull);
    assert(intent.screen.isNotNull);
    return pushAndRemoveUntil(intent, (route) => false,
        rootNavigator: rootNavigator);
  }

  ///pop screen đến khi gặp [intent.screen] thì ko pop nữa
  void popUntilScreen(PageIntent intent, {bool rootNavigator}) {
    assert(intent.isNotNull);
    assert(intent.screen.isNotNull);
    popUntil(ModalRoute.withName(intent.screen.toString()),
        rootNavigator: rootNavigator);
  }

  ///pop screen đến khi gặp [intent.screen] thì ko pop nữa
  ///nếu [intent.screen] == null, thì sẽ pop tới trang đầu tiên
  void popUntilScreenOrFirst(PageIntent intent, {bool rootNavigator}) {
    assert(intent.isNotNull);
    popUntil((route) {
      return '${intent.screen}' == route.settings.name || route.isFirst;
    }, rootNavigator: rootNavigator);
  }

  ///pop screen đến khi gặp [intent.screen] thì thoả điều kiện của [predicate] thì mới dừng pop
  void popUntil(RoutePredicate predicate, {bool rootNavigator}) {
    Navigator.of(this, rootNavigator: rootNavigator ?? false)
        .popUntil(predicate);
  }
}
