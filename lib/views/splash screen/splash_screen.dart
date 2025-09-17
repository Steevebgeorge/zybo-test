import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    //code to control animation in logo during startup
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // code to navigate from splas screen to otp screen
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/otpscreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          curve: Curves.easeIn,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/image1.png'),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset('assets/images/image.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
