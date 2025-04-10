import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rider_app/auth/SignUpScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app/global/global.dart';
import 'package:rider_app/MySpashScreen.dart';
import 'package:rider_app/widgets/progress_dialog.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      showDialog(
        context: context,
        builder:
            (BuildContext c) => const AlertDialog(
              title: Text("Email"),
              content: Text("Email address is not valid"),
            ),
      );
    } else if (passwordTextEditingController.text.isEmpty) {
      showDialog(
        context: context,
        builder:
            (BuildContext c) => const AlertDialog(
              title: Text("Password"),
              content: Text("Password is mandotory"),
            ),
      );
    } else {
      loginDriverNow();
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(message: "Processing, please wait...");
      },
    );
  }

  loginDriverNow() async {
    showLoadingDialog();

    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim(),
          );

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        
        currentFirebaseUser = firebaseUser;

        Navigator.pop(context);
        Fluttertoast.showToast(msg: "login successful");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => const Myspashscreen()));
        
      }
    } catch (error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: ${error.toString()}");
    }
  }

  void loginUser() async {
    String email = emailTextEditingController.text.trim();
    String password = passwordTextEditingController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
      return;
    }

    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      currentFirebaseUser = userCredential.user;
      Fluttertoast.showToast(msg: "Login successful");

      if (!context.mounted) return;

      // Navigate to SplashScreen to handle car info check
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Myspashscreen()),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: "Login Failed: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset("assets/images/image1.png"),
              ),
              const SizedBox(height: 20),
              const Text(
                "Login as driver",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Email",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  controller: passwordTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Signupscreen(),
                    ),
                  );
                },
                child: const Text(
                  "Do not have an account? Create account",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
