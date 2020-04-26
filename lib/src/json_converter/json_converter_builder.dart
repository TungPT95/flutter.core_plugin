import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/json_converter/json_converter_factory.dart';

class JsonConverterBuilder {
  static JsonConverterBuilder _builder;

  static JsonConverterBuilder get instance => _builder;

  JsonConverterFactory factory;

  static init(JsonConverterFactory factory) {
    if (_builder.isNull) {
      _builder = JsonConverterBuilder();
    }
    _builder.factory = factory;
  }
}
