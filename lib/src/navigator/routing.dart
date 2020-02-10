import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/navigator/bundle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class Routing {
  Map<dynamic, dynamic> getRoutes(Bundle settings);

  String getInitRoute() {
    return _getTypeName(getRoutes(null).entries.first.key);
  }

  Route<Bundle> onGenerateRoute(RouteSettings settings) {
    final bundle = (settings.arguments as Bundle) ?? Bundle.empty();
    return MaterialPageRoute(
        builder: (context) {
          return Provider<Bundle>.value(
            child: _buildRoutes(bundle)[settings.name],
            updateShouldNotify: (previous, next) => false,
            value: bundle,
          );
        },
        settings: settings);
  }

  Map<String, dynamic> _buildRoutes(Bundle bundle) {
    assert(getRoutes(bundle) != null, 'need to override getRoutes()');
    assert(getRoutes(bundle).isNotEmpty, 'getRoutes() is not empty!');
    return getRoutes(bundle).map((key, value) {
      return MapEntry(_getTypeName(key), value);
    });
  }

  String _getTypeName(Type type) => type.toString();
}
