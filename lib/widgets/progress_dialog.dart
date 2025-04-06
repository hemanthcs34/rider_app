import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String? message;
  const ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black45,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10.0,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(
              width: 20.0,
            ),
             const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(
              width: 20.0,
            ),

            Text(
              message!,
              style: const TextStyle(color: Colors.black, fontSize: 12.0),
            ),
          ],
        )
      ),
    );
  }
}
