import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/json_converter/json_converter_builder.dart';

class Converter<T> implements JsonConverter<T, Object> {
  const Converter();

  @override
  T fromJson(Object json) =>
      JsonConverterBuilder.instance?.factory?.fromJson<T>(json);

  @override
  Object toJson(T object) =>
      JsonConverterBuilder.instance?.factory?.toJson<T>(object);
}

bool decodeBoolFromInt(int input) {
  return input == 1;
}

int encodeBoolToInt(bool input) {
  return input ? 1 : 0;
}

int parseDynamicToInt(input) {
  if (input is int)
    return input;
  else if (input is String) {
    try {
      return int.tryParse(input);
    } catch (e) {
      return -1;
    }
  } else
    return -1;
}

int parseDynamicToSecond(input) {
  if (input is int)
    return input;
  else if (input is String) {
    try {
      return DateTime.parse(input).millisecondsSinceEpoch ~/ 1000;
    } catch (e) {
      return -1;
    }
  } else
    return -1;
}
