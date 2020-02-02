import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/navigator/bundle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class Routing {
  Map<dynamic, dynamic> getRoutes();

  String getInitRoute() {
    return _getTypeName(getRoutes().entries.first.key);
  }

  Route<Bundle> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) {
          return Provider<Bundle>.value(
            child: _buildRoutes()[settings.name],
            updateShouldNotify: (previous, next) => false,
            value: (settings.arguments as Bundle) ?? Bundle.empty(),
          );
        },
        settings: settings);
  }

  Map<String, dynamic> _buildRoutes() {
    assert(getRoutes() != null, 'need to override getRoutes()');
    assert(getRoutes().isNotEmpty, 'getRoutes() is not empty!');
    return getRoutes().map((key, value) {
      return MapEntry(_getTypeName(key), value);
    });
  }

  String _getTypeName(Type type) => type.toString();
}
