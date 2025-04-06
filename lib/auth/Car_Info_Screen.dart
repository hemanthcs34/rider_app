import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app/global/global.dart';
import 'package:rider_app/MySpashScreen.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController =
      TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();
  List<String> carTypesList = ["uber-X", "uber-go", "bike"];
  String? selectedCarType;
  saveCarInfo() {
    Map driverCarInfoMap = {
        "car_color": carColorTextEditingController.text.trim(),
        "car_number": carNumberTextEditingController.text.trim(),
        "car_model": carModelTextEditingController.text.trim(),
        "car_type": selectedCarType,
      };
       driversRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);
       Fluttertoast.showToast(
         msg: "Car info has been saved",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.black,
         textColor: Colors.white,
         fontSize: 16.0,
       );
       
       Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => const Myspashscreen(),
        ),
       );
  }
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
                  "write your car info",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: carModelTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "Car model",

                    hintText: "Car model",
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
                  controller: carNumberTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "Car number",

                    hintText: "Car number",
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
                  controller: carColorTextEditingController,
                  style: const TextStyle(color: Colors.grey),
                  decoration: const InputDecoration(
                    labelText: "Car color",

                    hintText: "Car color",
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

                DropdownButton(
                  iconSize: 20,
                  icon: Icon(Icons.map),
                  dropdownColor: Colors.black,
                  hint: const Text(
                    "please choose Car Type",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                  value: selectedCarType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCarType = newValue.toString();
                    });
                  },
                  items:
                      carTypesList.map((car) {
                        return DropdownMenuItem(
                          child: Text(
                            car,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          value: car,
                        );
                      }).toList(),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                   if(carColorTextEditingController.text.isNotEmpty && carModelTextEditingController.text.isNotEmpty && carNumberTextEditingController.text.isNotEmpty && selectedCarType != null) {
                     saveCarInfo();
                     Navigator.pushNamedAndRemoveUntil(context, "mainScreen", (route) => false);
                   } else {
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                         content: Text("please fill all the fields"),
                       ),
                     );
                   }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    "Save now",
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
