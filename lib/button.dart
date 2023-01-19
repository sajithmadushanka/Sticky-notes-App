import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final function;

  const Button({super.key, required this.text, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.pink,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
