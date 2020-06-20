import 'package:core_plugin/core_plugin.dart';

///phải đc init ở splash screen hoặc trước khi sử dụng
class SharedRef {
  static SharedPreferences _prefs;

  SharedRef._();

  static Future<dynamic> init() async {
    _prefs = await SharedPreferences.getInstance();
    return 1;
  }

  static void putString(String key, String value, {String defaultValue = ''}) {
    if (value.isNull) value = defaultValue;
    _prefs?.setString(key, value);
  }

  static String getString(String key) {
    return _prefs?.getString(key);
  }

  static void putInt(String key, int value, {int defaultValue = -1}) {
    if (value.isNull) value = defaultValue;
    _prefs?.setInt(key, value);
  }

  static int getInt(String key) {
    return _prefs.getInt(key);
  }
}
