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
        builder: (BuildContext c) {
          return const AlertDialog(
            title: Text("Name"),
            content: Text("Name must be at least 3 characters"),
          );
        },
      );
    } else if (!emailTextEditingController.text.contains("@")) {
      showDialog(
        context: context,
        builder: (BuildContext c) {
          return const AlertDialog(
            title: Text("Email"),
            content: Text("Email address is not valid"),
          );
        },
      );
    } else if (phoneTextEditingController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext c) {
          return const AlertDialog(
            title: Text("Phone"),
            content: Text("Phone number is required"),
          );
        },
      );
    } else if (passwordTextEditingController.text.length < 6) {
      showDialog(
        context: context,
        builder: (BuildContext c) {
          return const AlertDialog(
            title: Text("Password"),
            content: Text("Password must be at least 6 characters"),
          );
        },
      );
    } else {
      saveDriverInfo();
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(message: "processing, please wait...");
      },
    );
  }

  saveDriverInfo() async {
    showLoadingDialog();
    final User? firebaseUser =
        (await firebaseAuth
            .createUserWithEmailAndPassword(
              email: emailTextEditingController.text.trim(),
              password: passwordTextEditingController.text.trim(),
            )
            .catchError((msg) {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "Error:" + msg.toString());
            })).user;
    if (firebaseUser != null) {
      Map driverMap = {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };
      driversRef.child(firebaseUser.uid).set(driverMap);
      Fluttertoast.showToast(msg: "Account has been created");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CarInfoScreen(),
        ),
      );
      currentFirebaseUser = firebaseUser;
       Fluttertoast.showToast(msg: "Account has  been created");
      Navigator.push(context, MaterialPageRoute(builder: (c) => const CarInfoScreen()));
    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created");
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
                Text(
                  "Register as a driver",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextField(
                  controller: nameTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "Name",

                    hintText: "Name",
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
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "email",

                    hintText: "email",
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
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "phone",

                    hintText: "phone",
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
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  controller: passwordTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "password",

                    hintText: "password",
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
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CarInfoScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Loginscreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
