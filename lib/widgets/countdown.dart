import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountdownExample extends StatefulWidget {
  const CountdownExample({super.key});

  @override
  State<CountdownExample> createState() => _CountdownExampleState();
}

class _CountdownExampleState extends State<CountdownExample> {
  int seconds = 120; // starting value
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        t.cancel(); // stop when it reaches 0
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "00:${seconds.toString().padLeft(2, '0')} Sec",
      style: GoogleFonts.oxygen(
        fontSize: 14,
      ),
    );
  }
}
