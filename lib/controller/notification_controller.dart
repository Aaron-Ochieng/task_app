// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:theme_changer/models/task.dart';
import 'package:theme_changer/screens/notification_details.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();
  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    _configureLocalTimeZone();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      priority: Priority.high,
    );
    return const NotificationDetails(android: androidNotificationDetails);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  //Configure Local timeZone
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> scheduledNotification(int hours, int minutes, Task task) async {
    await _localNotificationService.zonedSchedule(
      task.id!,
      task.title,
      task.note,
      _convertTime(hours, minutes),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'description',
          importance: Importance.max,
          playSound: true,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "{$task.title |}" "{$task.note |}",
    );
  }

  void onDidRecieveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    print('id $id');
  }

  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      print(payload);
    } else {
      Get.to(() => NotificationDetailPage(label: payload));
    }
  }
}
