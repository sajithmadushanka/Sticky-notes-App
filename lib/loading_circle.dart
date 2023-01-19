import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // ignore: sized_box_for_whitespace
      child: Container(
        height: 25,
        width: 25,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
