import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'dart:math';

class Noti {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<int?>();

//##################################################################
  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('mipmap/ic_launcher');
    final ios = DarwinInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) async {
        onNotifications.add(payload.id);
      },
    );
    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

//##################################################################

  static Future _notificationsDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

//##################################################################
  static Future showNotification({
    int id = 0,
    required String? title,
    required String? body,
    String? payload,
  }) async {
    await _notifications.show(id, title, body, await _notificationsDetails(),
        payload: payload);
  }

//##################################################################
//
//   static Future makaSpecificTimeNotificationPeridoc(Duration duration) {
//     Timer.periodic(Duration(minutes: 30), () {
//       // Make a local notification
//       var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//           'your channel id', 'your channel name', 'your channel description',
//           importance: Importance.Max,
//           priority: Priority.High,
//           ticker: 'ticker');
//       var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//       var platformChannelSpecifics = NotificationDetails(
//           androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//       await flutterLocalNotificationsPlugin.show(
//           0, 'plain title', 'plain body', platformChannelSpecifics,
//           payload: 'item x');
//     });
//   }

  static Future notificationPeridoc({
    int id = 0,
    required String? title,
    required List<String> allList,
    String? payload,
  }) async {
    int index = Random().nextInt(allList.length - 1);

    String body = allList[index];

    await _notifications.periodicallyShow(
      id + index,
      title,
      body,
      RepeatInterval.daily,
      await _notificationsDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
    );
  }
  /*await flutterLocalNotificationsPlugin.periodicallyShow(
    Random().nextInt(azkar.length-1),
    'السلام عليكم',
    azkar[Random().nextInt(azkar.length-1)],
    RepeatInterval.everyMinute,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    payload: '',
  );*/

//##################################################################
  static Future notificationScheduled(
      {int id = 0,
      required String? title,
      required String? body,
      String? payload,
      required Time time}) async {
    await _notifications.zonedSchedule(
        id,
        title,
        body,
        // tz.TZDateTime.from(scheduled, tz.local),
        _scheduleWeekly(time, days: [
          DateTime.friday,
          DateTime.saturday,
          DateTime.sunday,
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
        ]),
        await _notificationsDetails(),
        payload: payload,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    return scheduleDate.isBefore(now)
        ? scheduleDate.add(Duration(days: 1))
        : scheduleDate;
  }

  static tz.TZDateTime _scheduleWeekly(Time time, {required List<int> days}) {
    tz.TZDateTime schduledData = _scheduleDaily(time);

    while (!days.contains(schduledData.weekday)) {
      schduledData = schduledData.add(Duration(days: 1));
    }
    return schduledData;
  }

//##################################################################
  static Future cancelSpecificNot(int id) async {
    await _notifications.cancel(id);
  }

//##################################################################
}
