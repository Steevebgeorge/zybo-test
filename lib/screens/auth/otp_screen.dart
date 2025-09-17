import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zybo_test/views/auth/otp_verification_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * .15),
              Text(
                'Login',
                style: GoogleFonts.oxygen(
                    fontSize: 35, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8),
              Text(
                "Let's Connect with Lorem ipsum..!",
                style: GoogleFonts.manrope(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '+91',
                        hintStyle: GoogleFonts.oxygen(fontSize: 14),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(width: 18), // spacing
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter phone',
                        hintStyle: GoogleFonts.oxygen(fontSize: 14),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpVerificationScreen(),
                    ),
                  );
                },
                child: Container(
                  width: size.width,
                  height: size.height * 0.07,
                  decoration: const BoxDecoration(
                    color: Color(0xFF5E5BE2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: GoogleFonts.oxygen(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              SizedBox(
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 10),
                        children: [
                          const TextSpan(
                              text: 'By Continuing you accepting the'),
                          TextSpan(
                              text: ' Terms of Use &\nPrivacy Policy',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  debugPrint("Privacy policy clicked");
                                }),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
