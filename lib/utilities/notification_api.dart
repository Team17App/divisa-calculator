/* import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static const String channelId = 'com.herramientasvirtuales.sistemapos';
  static const String channelName = 'sistemapos';
  static const String channelDescription =
      'channel Description from Sistema POS';
  static const String icon = 'drawable/ic_notification';

  static Future _notificationDetail(
      {AndroidNotificationDetails? android}) async {
    return NotificationDetails(
      android: android ??
          const AndroidNotificationDetails(
            channelId,
            channelName,
            channelDescription: channelDescription,
            icon: icon,
            importance: Importance.max,
          ),
      iOS: const IOSNotificationDetails(),
    );
  }

  static Future init() async {
    // permission notifications show
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    // init
    const android = AndroidInitializationSettings(icon);
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    bool playSound = true,
    AndroidNotificationDetails? androidNotificationDetails,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetail(
          android: androidNotificationDetails,
        ),
        payload: payload,
      );

  static ssss() {}
}
 */