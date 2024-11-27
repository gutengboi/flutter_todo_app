import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  initializeNotification() async {
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

  // Handle notification taps
  void onDidReceiveNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      print('Notification payload: $payload');
    } else {
      print("Notification Tapped without Payload");
    }
    Get.to(() => Container(color: Colors.white));
  }

  // Method for displaying a dialog in iOS (if needed)
  void handleLocalNotificationDialog(
      int id, String? title, String? body, String? payload) {
    Get.dialog(
      Text("welcome to flutter")
      // AlertDialog(
      //   title: Text(title ?? "Notification"),
      //   content: Text(body ?? "You have received a notification."),
      //   actions: [
      //     TextButton(
      //       child: const Text("OK"),
      //       onPressed: () {
      //         Get.back();
      //         Get.to(() => Container(color: Colors.white));
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
