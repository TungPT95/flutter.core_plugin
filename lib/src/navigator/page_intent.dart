import 'package:core_plugin/src/navigator/bundle.dart';
import 'package:flutter/widgets.dart';

class PageIntent {
  final BuildContext context;
  final Type screen;

  Bundle bundle;

  PageIntent(this.context, this.screen, {this.bundle});
}
