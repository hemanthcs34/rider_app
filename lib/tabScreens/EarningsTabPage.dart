
import 'package:flutter/material.dart';

class Earningstabpage extends StatefulWidget {
  const Earningstabpage({super.key});

  @override
  State<Earningstabpage> createState() => _EarningstabpageState();
}

class _EarningstabpageState extends State<Earningstabpage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "this is earning tab",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}