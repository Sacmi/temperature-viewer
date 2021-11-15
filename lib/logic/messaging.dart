import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CloudMessaging {
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  late FirebaseMessaging _messaging;

  late AndroidNotificationChannel _channel;

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  static const String _mainTopic = "main";

  Future<bool> initialize() async {
    if (kIsWeb) {
      return false;
    }

    try {
      await Firebase.initializeApp();
    } catch (e) {
      return false;
    }

    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      return false;
    }

    _channel = const AndroidNotificationChannel(
      'channel', // id
      'Уведомления от сенсоров', // title
      description:
          'Данный канал используется для уведомлений от сенсоров', // description
      importance: Importance.max,
    );

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _androidNotification();
    await _subscribeToBroadcast();

    _isInitialized = true;

    return true;
  }

  void _androidNotification() {
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        _flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _channel.id,
                _channel.name,
                channelDescription: _channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });
  }

  Future<void> _subscribeToBroadcast() async {
    if (!kIsWeb) {
      await _messaging.subscribeToTopic(_mainTopic);
    }
  }
}
