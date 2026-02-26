// lib/services/notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';
import 'dart:io' show Platform;

class NotificationService extends GetxService {
  final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings();

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);

    // Request permissions for Android
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      _notifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      // Request notification permission
      await androidImplementation?.requestNotificationsPermission();

      // For Android 13+, request notification permission
      if (await androidImplementation?.areNotificationsEnabled() == false) {
        await androidImplementation?.requestNotificationsPermission();
      }
    }
  }

  Future<void> scheduleHealthReminder() async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'health_channel',
        'Health Reminders',
        channelDescription: 'Notifications for health activities',
        importance: Importance.high,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
      );

      const iosDetails = DarwinNotificationDetails();

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // Use hourly interval with inexact timing (works on all Android versions)
      await _notifications.periodicallyShow(
        0,
        'Time to Move! 🏃',
        'Take a walk and stay healthy!',
        RepeatInterval.hourly,
        details,
        androidScheduleMode: AndroidScheduleMode.inexact,
      );

      print('Health reminder scheduled successfully');

    } catch (e) {
      print('Error scheduling notification: $e');
      // Fallback to show a one-time notification
      await showImmediateNotification(
          'Health Reminder',
          'Remember to stay active!'
      );
    }
  }

  Future<void> showImmediateNotification(String title, String body) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'immediate_channel',
        'Immediate Notifications',
        importance: Importance.high,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
      );

      const iosDetails = DarwinNotificationDetails();

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(
        DateTime.now().millisecond,
        title,
        body,
        details,
      );
    } catch (e) {
      print('Error showing immediate notification: $e');
    }
  }

  // Optional: Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      final androidImplementation = _notifications
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      return await androidImplementation?.areNotificationsEnabled() ?? false;
    }
    return true; // iOS doesn't have this check
  }
}