
import 'package:flutter/material.dart';

class Hometabpage extends StatefulWidget {
  const Hometabpage({super.key});

  @override
  State<Hometabpage> createState() => _HometabpageState();
}

class _HometabpageState extends State<Hometabpage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "this is home tab",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}