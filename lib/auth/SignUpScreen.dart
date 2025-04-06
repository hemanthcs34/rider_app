import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rider_app/auth/Car_Info_Screen.dart';
import 'package:rider_app/global/global.dart';
import 'package:rider_app/widgets/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'LoginScreen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();

  validateForm() {
    if (nameTextEditingController.text.length < 3) {
      showDialog(
        context: context,
        builder: (BuildContext c) => const AlertDialog(
          title: Text("Name"),
          content: Text("Name must be at least 3 characters"),
        ),
      );
    } else if (!emailTextEditingController.text.contains("@")) {
      showDialog(
        context: context,
        builder: (BuildContext c) => const AlertDialog(
          title: Text("Email"),
          content: Text("Email address is not valid"),
        ),
      );
    } else if (phoneTextEditingController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext c) => const AlertDialog(
          title: Text("Phone"),
          content: Text("Phone number is required"),
        ),
      );
    } else if (passwordTextEditingController.text.length < 6) {
      showDialog(
        context: context,
        builder: (BuildContext c) => const AlertDialog(
          title: Text("Password"),
          content: Text("Password must be at least 6 characters"),
        ),
      );
    } else {
      saveDriverInfo();
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) => ProgressDialog(message: "Processing, please wait..."),
    );
  }

  saveDriverInfo() async {
    showLoadingDialog();

    try {
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      );

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        Map<String, dynamic> driverMap = {
          "id": firebaseUser.uid,
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),
        };

        await driversRef.child(firebaseUser.uid).set(driverMap);

        currentFirebaseUser = firebaseUser;

        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Account has been created");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => const CarInfoScreen()),
        );
      }
    } catch (error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: ${error.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/image1.png"),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Register as a driver",
                  style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "Name",
                    hintText: "Name",
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Email",
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    hintText: "Phone",
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  controller: passwordTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: validateForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  ),
                  child: const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Loginscreen()),
                    );
                  },
                  child: const Text("Already have an account? Login", style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
