import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zybo_test/blocs/login%20bloc/bloc/login_user_bloc.dart';
import 'package:zybo_test/views/auth/name_register_screen.dart';
import 'package:zybo_test/widgets/countdown.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String? phonenumber;
  final String? otp;
  final bool? isUser;

  const OtpVerificationScreen({
    super.key,
    this.phonenumber,
    this.otp,
    this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    TextEditingController box1 = TextEditingController();
    TextEditingController box2 = TextEditingController();
    TextEditingController box3 = TextEditingController();
    TextEditingController box4 = TextEditingController();

    String getOtp() {
      return box1.text + box2.text + box3.text + box4.text;
    }

    return BlocProvider(
      create: (_) => LoginUserBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.09),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                "OTP VERIFICATION",
                style: GoogleFonts.oxygen(
                    fontWeight: FontWeight.bold, fontSize: 21),
              ),
              SizedBox(height: size.height * 0.02),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.oxygen(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(text: "Enter the OTP sent to"),
                    TextSpan(
                      text: "- +91-$phonenumber",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.oxygen(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: "OTP is ", style: GoogleFonts.oxygen()),
                    TextSpan(
                      text: otp ?? "1234",
                      style: GoogleFonts.oxygen(
                          color: const Color(0xFF5E5BE2),
                          fontWeight: FontWeight.w800,
                          fontSize: 19),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _otpBox(box1, context),
                  _otpBox(box2, context),
                  _otpBox(box3, context),
                  _otpBox(box4, context),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              const Center(child: CountdownExample()),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.oxygen(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Don't receive code? ",
                          style: GoogleFonts.oxygen(),
                        ),
                        TextSpan(
                          text: "Re-send",
                          style: GoogleFonts.oxygen(
                            color: Color.fromARGB(255, 50, 228, 169),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      final enteredOtp = getOtp().trim();
                      if (enteredOtp.length == 4) {
                        if (enteredOtp == (otp ?? "1234")) {
                          if (isUser == true) {
                            context.read<LoginUserBloc>().add(
                                  LoginUserRequested(phoneNumber: phonenumber!),
                                );
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => RegisterNameScreen(
                                      phoneNumber: phonenumber!,
                                    )));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Invalid OTP")),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Enter complete OTP")),
                        );
                      }
                    },
                    child: Container(
                      width: size.width,
                      height: size.height * 0.07,
                      decoration: const BoxDecoration(
                        color: Color(0xFF5E5BE2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: BlocConsumer<LoginUserBloc, LoginUserState>(
                        listener: (context, state) {
                          if (state is LoginUserSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.user.message)),
                            );
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/homescreen', // The new route you want to push
                              ModalRoute.withName(
                                  '/homescreen'), 
                            );
                          } else if (state is LoginUserError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (isUser == true) {
                            return state is LoginUserLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'Submit',
                                      style: GoogleFonts.oxygen(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20,
                                      ),
                                    ),
                                  );
                          } else {
                            return const Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpBox(TextEditingController controller, BuildContext context) {
    return Container(
      height: 70,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(99, 0, 0, 0),
            offset: Offset(-2, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
