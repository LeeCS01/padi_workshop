import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class AwesomeNotificationApp extends StatefulWidget {
  @override
  _AwesomeNotificationAppState createState() => _AwesomeNotificationAppState();
}

class _AwesomeNotificationAppState extends State<AwesomeNotificationApp> {
  @override
  void initState() {
    // Check if notifications are allowed and request permission if not
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  void triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'all_users_channel', // Unique channel key
        title: 'Awesome Notification',
        body: 'This is an example notification for all users.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Awesome Notification Integration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is a stateful widget with Awesome Notification integration.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: triggerNotification,
              child: Text('Create Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
