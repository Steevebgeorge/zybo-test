import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:zybo_test/views/home%20screen/homescreen.dart';
import 'package:zybo_test/views/profile%20screen/profile_screen.dart';
import 'package:zybo_test/views/wishlist%20screen/wishlistscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ItemsScreen(),
    const WishlistScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: GNav(
              gap: 8,
              activeColor: Colors.white,
              color: Colors.black,
              tabBackgroundColor: const Color(0xFF5E5BE2),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: 'Wishlist',
                ),
                GButton(
                  icon: Icons.person_2_outlined,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
