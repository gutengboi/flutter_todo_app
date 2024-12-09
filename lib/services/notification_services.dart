import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:flutter_todo_app/ui/notified_page.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/task.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'your_channel_id', // Channel ID used for notifications
      'Your Channel Name', // Channel name visible to the user
      description: 'This channel is used for important notifications.', // Channel description
      importance: Importance.max, // Importance of the channel
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    print("Notification channel created.");
  }

  initializeNotification() async {
    _configureLocalTimezone();
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("appicon");

    const InitializationSettings initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // Updated listener for notification taps
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  displayNotification({required String title, required String body}) async {
    print("doing test");

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }

  scheduledNotification(int hour, int minutes, Task task) async {

    final scheduledTime = _convertTime(hour, minutes);
    print("Scheduled notification time: $scheduledTime");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!.toInt(),
      task.title,
      task.note,
      _convertTime(hour, minutes),
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // Use the updated parameter
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${task.title}|"+"${task.note}|"
    );
  }

  // scheduledNotification(int hour, int minutes, Task task) async {
  //   try {
  //     final scheduledTime = _convertTime(hour, minutes);
  //     print("Scheduled notification time: $scheduledTime");
  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       task.id!.toInt(),
  //       task.title,
  //       task.note,
  //       scheduledTime,
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'your_channel_id',
  //           'Your Channel Name',
  //           channelDescription: 'This channel is used for important notifications.',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //         ),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.time,
  //     );
  //     print("Notification successfully scheduled");
  //   } catch (e) {
  //     print("Error scheduling notification: $e");
  //   }
  // }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    print("Scheduled notification time: $scheduleDate");
    return scheduleDate;
  }

  Future<void> _configureLocalTimezone() async{
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Handle notification taps
  void onDidReceiveNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      print('Notification payload: $payload');
    } else {
      print("Notification Tapped without Payload");
    }

    if(payload== "Theme changed"){
      print("Nothing to navigate to");
    }else {
      Get.to(() => NotifiedPage(label: payload));
    }
  }

  // Method for displaying a dialog in iOS (if needed)
  void handleLocalNotificationDialog(
      int id, String? title, String? body, String? payload) {
    Get.dialog(
      Text("welcome to flutter"),
    );
  }
}
