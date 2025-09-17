import 'package:flutter/material.dart';
import 'package:zybo_test/views/auth/otp_screen.dart';
import 'package:zybo_test/views/splash%20screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zybo test',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/otpscreen': (context) => OtpScreen(),
      },
    );
  }
}
