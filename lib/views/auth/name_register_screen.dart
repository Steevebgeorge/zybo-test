import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zybo_test/blocs/Register%20bloc/register_user_bloc.dart';
import 'package:zybo_test/widgets/navbar.dart';

class RegisterNameScreen extends StatelessWidget {
  final String phoneNumber;
  const RegisterNameScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<RegisterUserBloc, RegisterUserState>(
        listener: (context, state) {
          if (state is RegisterUserSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is RegisterUserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
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
                SizedBox(height: size.height * 0.09),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Full Name',
                    hintStyle: GoogleFonts.oxygen(),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                GestureDetector(
                  onTap: () {
                    final name = nameController.text.trim();
                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter your name")),
                      );
                      return;
                    }
                    context.read<RegisterUserBloc>().add(
                          RegisterUserRequested(
                            phoneNumber: phoneNumber,
                            name: name,
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
                      child: state is RegisterUserLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Submit',
                              style: GoogleFonts.oxygen(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
