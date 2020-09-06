import 'package:core_plugin/src/navigator/bundle.dart';

class PageIntent {
  final Type screen;

  ///khi muốn dùng context từ thằng root navigator của app
  final bool rootNavigator;

  Bundle bundle;

  PageIntent({this.screen, this.bundle, this.rootNavigator});
}
