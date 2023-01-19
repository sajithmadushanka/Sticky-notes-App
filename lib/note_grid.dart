import 'package:flutter/material.dart';
import 'package:stickynotes/goole_sheets_api.dart';
import 'package:stickynotes/textbox.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: GoogleApi.currentesNotes.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: ((context, index) {
        return MyTextBox(
          text: GoogleApi.currentesNotes[index],
        );
      }),
    );
  }
}
