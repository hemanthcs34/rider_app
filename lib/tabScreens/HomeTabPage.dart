import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rider_app/global/global.dart';
import 'package:rider_app/auth/LoginScreen.dart';
import 'package:firebase_database/firebase_database.dart';

class Hometabpage extends StatefulWidget {
  const Hometabpage({super.key});

  @override
  State<Hometabpage> createState() => _HometabpageState();
}

class _HometabpageState extends State<Hometabpage> {
  String driverName = "Loading...";
  String carType = "";

  @override
  void initState() {
    super.initState();
    fetchDriverInfo();
  }

  void fetchDriverInfo() async {
    DatabaseReference driverRef = driversRef.child(currentFirebaseUser!.uid);
    DataSnapshot snapshot = await driverRef.once().then((value) => value.snapshot);

    if (snapshot.value != null) {
      Map data = snapshot.value as Map;

      setState(() {
        driverName = data["name"] ?? "Driver";
        carType = data["car_details"]?["car_type"] ?? "";
      });
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Loginscreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Home", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, $driverName",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            if (carType.isNotEmpty)
              Text(
                "Car Type: $carType",
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
