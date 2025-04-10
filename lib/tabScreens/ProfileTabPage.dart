
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/MySpashScreen.dart';
import 'package:rider_app/auth/LoginScreen.dart';


class Profiletabpage extends StatefulWidget {
  const Profiletabpage({super.key});

  @override
  State<Profiletabpage> createState() => _ProfiletabpageState();
}

class _ProfiletabpageState extends State<Profiletabpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Sign Out"),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Myspashscreen()),
              );
            }).catchError((error) {
              print("Error signing out: $error");
            });
          },
        ),
      ),
    );
  }
}