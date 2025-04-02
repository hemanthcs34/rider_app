
import 'package:flutter/material.dart';

class Ratingtabpage extends StatefulWidget {
  const Ratingtabpage({super.key});

  @override
  State<Ratingtabpage> createState() => _RatingtabpageState();
}

class _RatingtabpageState extends State<Ratingtabpage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "this is rating tab",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}