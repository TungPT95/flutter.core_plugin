library firebase_messaging_utils;

import 'dart:convert';

export 'package:core_plugin/src/firebase_messaging_utils/models/aps/firebase_messaging_aps.dart';
export 'package:core_plugin/src/firebase_messaging_utils/models/data/base_firebase_messaging_data.dart';
export 'package:core_plugin/src/firebase_messaging_utils/models/firebase_messaging_response.dart';
export 'package:core_plugin/src/firebase_messaging_utils/models/notification/firebase_messaging_notification.dart';

class FirebaseMessagingUtils {
  FirebaseMessagingUtils._();

  static Map<String, dynamic> decodeJson(json) => jsonDecode(jsonEncode(json));
}
