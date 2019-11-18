import 'package:core_plugin/src/navigator/bundle.dart';
import 'package:flutter/widgets.dart';

class Intent {
  final BuildContext context;
  final Type screen;

  Bundle bundle;

  Intent(this.context, this.screen, {this.bundle});
}
