import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final text;

  const MyTextBox({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.yellow[300],
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
