import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OneSignal.shared.setAppId('1ade5bc8-8c55-4a5d-a6b4-208a57b3051b');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OneSignal Integration',
      home: OneSignalApp(),
    );
  }
}

class OneSignalApp extends StatefulWidget {
  @override
  _OneSignalAppState createState() => _OneSignalAppState();
}

class _OneSignalAppState extends State<OneSignalApp> {
  OSDeviceState? deviceState;

  @override
  void initState() {
    super.initState();
    configOneSignal();
    fetchDeviceState();
  }

  void configOneSignal() {
    OneSignal.shared.setAppId('1ade5bc8-8c55-4a5d-a6b4-208a57b3051b');
  }

  Future<void> fetchDeviceState() async {
    try {
      var deviceState = await OneSignal.shared.getDeviceState();
      setState(() {
        this.deviceState = deviceState;
      });
    } catch (e) {
      print('Error fetching device state: $e');
    }
  }

  void sendNotification() async {
    final String endpoint = "http://10.131.73.60/sawahcek/send_notification.php";

    try {
      final response = await http.post(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OneSignal Integration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is a stateful widget with OneSignal integration.',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: sendNotification,
              child: Text('Send Notification'),
            ),
            SizedBox(height: 20),
            if (deviceState != null)
              Text('OneSignal Player ID: ${deviceState!.userId}'),
            if (deviceState == null)
              Text('OneSignal Player ID: Loading...'),
          ],
        ),
      ),
    );
  }
}
