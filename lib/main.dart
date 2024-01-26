import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sawahcek/screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  // Initialize OneSignal with your App ID
  OneSignal.shared.setAppId('1ade5bc8-8c55-4a5d-a6b4-208a57b3051b');

  // Request push notification permission from the user
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    // Handle the user's response if needed
    print('Push notification permission accepted: $accepted');
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sawah Check App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(230, 248, 255, 20),),
        //useMaterial3: true,
      ),
      home:    const SplashScreen(),
    );
  }
}