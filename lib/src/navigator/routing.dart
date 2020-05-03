import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/navigator/bundle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class Routing {
  ///override ở main, để get Map của all screen trong app
  Widget getRoutes(Type screen) => screenNotFound;

  ///gọi để set ở [MaterialApp.onGenerateRoute]
  Route<Bundle> onGenerateRoute(RouteSettings settings) {
    final intent = settings.arguments as PageIntent;
    final bundle = intent?.bundle ?? Bundle.empty();

    return MaterialPageRoute(
        builder: (context) {
          return Provider<Bundle>.value(
            child: getRoutes(intent?.screen),
            updateShouldNotify: (previous, next) => false,
            value: bundle,
          );
        },
        settings: settings);
  }
}

Widget screenNotFound = Material(
  child: Center(
    child: Text('Screen is not found!'),
  ),
);
