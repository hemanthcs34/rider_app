import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/tabScreens/Hometabpage.dart';
import 'package:rider_app/auth/loginScreen.dart';
import 'package:rider_app/auth/Car_Info_Screen.dart';
import 'package:rider_app/global/global.dart';

class Myspashscreen extends StatefulWidget {
  const Myspashscreen({super.key});

  @override
  State<Myspashscreen> createState() => _MyspashscreenState();
}

class _MyspashscreenState extends State<Myspashscreen> {
  void startTimer() {
    Timer(const Duration(seconds: 3), () async {
      currentFirebaseUser = FirebaseAuth.instance.currentUser;

      if (currentFirebaseUser != null) {
        DatabaseReference carInfoRef = FirebaseDatabase.instance
            .ref()
            .child("drivers")
            .child(currentFirebaseUser!.uid)
            .child("car_details");

        final snapshot = await carInfoRef.once();

        if (snapshot.snapshot.value != null) {
          // Car info exists -> go to Hometabpage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Hometabpage()),
          );
        } else {
          // No car info -> go to CarInfoScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CarInfoScreen()),
          );
        }
      } else {
        // Not signed in -> go to login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Loginscreen()),
        );
      }
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
              const SizedBox(height: 20),
              const Text(
                "Welcome here",
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
