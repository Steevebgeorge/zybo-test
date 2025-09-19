import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zybo_test/blocs/profile_bloc/bloc/fetch_profile_bloc.dart';
import 'package:zybo_test/blocs/profile_bloc/bloc/fetch_profile_event.dart';
import 'package:zybo_test/blocs/profile_bloc/bloc/fetch_profile_state.dart';
import 'package:zybo_test/constants/secure_storage.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => FetchProfileBloc()..add(FetchProfileRequested()),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<FetchProfileBloc, FetchProfileState>(
            builder: (context, state) {
              if (state is FetchProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchProfileError) {
                return Center(child: Text(state.message));
              } else if (state is FetchProfileSuccess) {
                final user = state.userData;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.09),
                      Text("My Profile",
                          style: GoogleFonts.oxygen(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: size.height * 0.02),
                      Text("Name",
                          style: GoogleFonts.oxygen(
                              color: Colors.grey, fontSize: 18)),
                      SizedBox(height: size.height * 0.01),
                      Text(user["first_name"] ?? "N/A",
                          style: GoogleFonts.oxygen(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: size.height * 0.02),
                      Text("Phone",
                          style: GoogleFonts.oxygen(
                              color: Colors.grey, fontSize: 18)),
                      SizedBox(height: size.height * 0.01),
                      Text(user["phone_number"] ?? "N/A",
                          style: GoogleFonts.oxygen(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                final storage = SecureStorageService();
                await storage.deleteToken();

                if (!context.mounted) return; // ✅ safety check
                Navigator.pushReplacementNamed(context, '/otpscreen');
              }
            },
            child: const Icon(Icons.logout, color: Colors.black),
          )),
    );
  }
}
