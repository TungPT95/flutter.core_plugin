import 'dart:async';
import 'dart:convert';

import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/firebase_messaging_utils/firebase_messaging_interface.dart';
import 'package:core_plugin/src/firebase_messaging_utils/firebase_messaging_notification_helper.dart';
import 'package:core_plugin/src/firebase_messaging_utils/module/firebase_messaging_module_parser.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class FirebaseMessagingModule {
  factory FirebaseMessagingModule.init() = _FirebaseMessagingModuleImpl._;

  FirebaseMessagingModule._();

  FlutterLocalNotificationsPlugin localNotificationsPlugin;
  FirebaseMessaging firebaseMessaging;

  ///lắng nghe event khi user click vào notification, nên set ở root screen
  void setListener({FirebaseMessagingInterface view});

  ///remove khi rời khỏi screen
  void removeListener();

  ///get điều kiện nào thì đc push notification
  void setNotificationHelper(FirebaseMessagingNotificationHelper helper);

  ///remove khi rời khỏi screen
  void removeNotificationHelper();

  ///call đầu tiên ở main.dart
  void initState({FirebaseMessagingModuleParser parser});

  void disposed();
}

class _FirebaseMessagingModuleImpl extends FirebaseMessagingModule {
  FirebaseMessagingModuleParser _parser;
  FirebaseMessagingInterface _view;
  FirebaseMessagingNotificationHelper _notificationHelper;

  _FirebaseMessagingModuleImpl._() : super._();

  @override
  void initState({FirebaseMessagingModuleParser parser}) {
    this._parser = parser;
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    localNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onOpenNotification);
    firebaseMessaging = FirebaseMessaging();
    firebaseMessaging.configure(
      onMessage: (message) async {
        final object =
            _parser.onMessage(FirebaseMessagingUtils.decodeJson(message));
        if (_notificationHelper?.canShowNotification(object.data) ?? true) {
          _showLocalNotification(response: object.response, data: object.data);
        }
      },
      onResume: (message) async {
        final object =
            _parser.onMessage(FirebaseMessagingUtils.decodeJson(message));
        _onOpenNotification(jsonEncode(object.data));
      },
      onLaunch: (message) async {
        final object =
            _parser.onMessage(FirebaseMessagingUtils.decodeJson(message));
        _onOpenNotification(jsonEncode(object.data));
      },
    );
  }

  @override
  void disposed() {}

  Future<dynamic> _onOpenNotification(String data) async {
    _view?.onOpenNotification(jsonDecode(data));
  }

  void _showLocalNotification(
      {FirebaseMessagingResponse response, Map<String, dynamic> data}) {
    final notificationId = DateTime.now().second.toString();
    final androidDetail = AndroidNotificationDetails(
        notificationId, 'FcmNotification', '',
        priority: Priority.high, importance: Importance.max);
    final iosDetail = IOSNotificationDetails();
    final platformDetail =
        NotificationDetails(android: androidDetail, iOS: iosDetail);
    localNotificationsPlugin.show(int.parse(notificationId), response.title,
        response.body, platformDetail,
        payload: jsonEncode(data));
  }

  @override
  void setListener({FirebaseMessagingInterface view}) {
    this._view = view;
  }

  @override
  void setNotificationHelper(FirebaseMessagingNotificationHelper helper) {
    this._notificationHelper = helper;
  }

  @override
  void removeNotificationHelper() {
    this._notificationHelper = null;
  }

  @override
  void removeListener() {
    this._view = null;
  }
}
