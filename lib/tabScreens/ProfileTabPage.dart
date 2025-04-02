
import 'package:flutter/material.dart';

class Profiletabpage extends StatefulWidget {
  const Profiletabpage({super.key});

  @override
  State<Profiletabpage> createState() => _ProfiletabpageState();
}

class _ProfiletabpageState extends State<Profiletabpage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "this is profile tab",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}