import 'package:flutter/material.dart';
import 'package:sawahcek/screen/splash_screen.dart';

void main() {
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