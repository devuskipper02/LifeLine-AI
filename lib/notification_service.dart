import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
static final FlutterLocalNotificationsPlugin notifications =
FlutterLocalNotificationsPlugin();

static Future<void> init() async {
const android = AndroidInitializationSettings('@mipmap/ic_launcher');

```
const settings = InitializationSettings(
  android: android,
);

await notifications.initialize(settings);
```

}

static Future<void> showNotification() async {
const details = NotificationDetails(
android: AndroidNotificationDetails(
'medicine_channel',
'Medicine Reminder',
importance: Importance.max,
priority: Priority.high,
),
);

```
await notifications.show(
  0,
  'Medicine Reminder',
  'Time to take your medicine 💊',
  details,
);
```

}
}
