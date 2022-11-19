import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('ic_launcher');
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
    String? payLoad,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payLoad,
      );

  static Future showScheduledNotification({
    int id = 0,
    String? payLoad,
    required int hours,
    required int minutes,
  }) async {
    final currentHour = DateTime.now().hour;
    final currentMinute = DateTime.now().minute;
    final notificationHour = hours - currentHour;
    final notificationMinute = minutes - currentMinute;
    _notifications.zonedSchedule(
      id,
      'Book Habits',
      "Don't you think it's time to read?",
      tz.TZDateTime.from(DateTime.now(), tz.local).add(Duration(
        hours: notificationHour,
        minutes: notificationMinute,
      )),
      await _notificationDetails(),
      payload: payLoad,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
