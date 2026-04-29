import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final NotificationService Instance = NotificationService._();

  final FlutterLocalNotificationsPlugin Notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> Initialize() async {
    const AndroidInitializationSettings AndroidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings IOSSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings Settings = InitializationSettings(
      android: AndroidSettings,
      iOS: IOSSettings,
    );

    await Notifications.initialize(settings: Settings);

    await _ConfigureLocalTimeZone();
    await _RequestPermissions();
  }

  Future<void> _ConfigureLocalTimeZone() async {
    tz.initializeTimeZones();

    final TimezoneInfo TimeZoneInfo = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(TimeZoneInfo.identifier));
  }

  Future<void> _RequestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? AndroidImplementation =
        Notifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await AndroidImplementation?.requestNotificationsPermission();

    final IOSFlutterLocalNotificationsPlugin? IOSImplementation =
        Notifications.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    await IOSImplementation?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  NotificationDetails _NotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'bulkpal_reminders',
        'BulkPal Reminders',
        channelDescription: 'Reminders to finish calorie targets',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> ShowInstantNotification() async {
    await Notifications.show(
      id: 999,
      title: 'BulkPal Reminder',
      body: 'Don’t forget to finish your calories today.',
      notificationDetails: _NotificationDetails(),
    );
  }

  Future<void> ScheduleDailyCalorieReminders() async {
    await CancelCalorieReminders();

    final List<int> ReminderHours = [10, 14, 18, 22];

    for (int Index = 0; Index < ReminderHours.length; Index++) {
      final int Hour = ReminderHours[Index];

      await Notifications.zonedSchedule(
        id: 100 + Index,
        title: 'BulkPal Reminder',
        body: 'Don’t forget to finish your calories.',
        scheduledDate: _NextInstanceOfHour(Hour),
        notificationDetails: _NotificationDetails(),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  Future<void> CancelCalorieReminders() async {
    for (int Id = 100; Id <= 103; Id++) {
      await Notifications.cancel(id: Id);
    }
  }

  tz.TZDateTime _NextInstanceOfHour(int Hour) {
    final tz.TZDateTime Now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime ScheduledDate = tz.TZDateTime(
      tz.local,
      Now.year,
      Now.month,
      Now.day,
      Hour,
    );

    if (ScheduledDate.isBefore(Now)) {
      ScheduledDate = ScheduledDate.add(const Duration(days: 1));
    }

    return ScheduledDate;
  }
}
