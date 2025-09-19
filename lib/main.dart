import 'package:flutter/material.dart';
import 'package:zybo_test/constants/app_providers.dart';
import 'package:zybo_test/views/auth/otp_screen.dart';
import 'package:zybo_test/views/auth/otp_verification_screen.dart';
import 'package:zybo_test/views/splash%20screen/splash_screen.dart';
import 'package:zybo_test/widgets/navbar.dart';

void main() {
  runApp(AppProviders());
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
        '/otpverificationscreen': (context) => OtpVerificationScreen(),
        '/homescreen': (context) => HomeScreen(),
      },
    );
  }
}
