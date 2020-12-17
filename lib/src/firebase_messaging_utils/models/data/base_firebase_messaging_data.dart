import 'package:core_plugin/core_plugin.dart';

abstract class BaseFirebaseMessagingData {
  @JsonKey(name: 'click_action')
  String clickAction;
}
