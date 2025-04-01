import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rider_app/MainScreens/MainScreen.dart';

class Myspashscreen extends StatefulWidget {
  const Myspashscreen({super.key});

  @override
  State<Myspashscreen> createState() => _MyspashscreenState();
}

class _MyspashscreenState extends State<Myspashscreen> {
  void startTimer() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Mainscreen()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/image1.png"),
              const Text(
                "welcome here",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
