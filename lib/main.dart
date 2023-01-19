import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:stickynotes/button.dart';
import 'package:stickynotes/goole_sheets_api.dart';
import 'package:stickynotes/loading_circle.dart';
import 'package:stickynotes/note_grid.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleApi().init();
  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

// loadting timer
  void startLoading() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleApi.loading == false) {
        timer.cancel();
        setState(() {});
      }
    });
  }

  final TextEditingController _controller = TextEditingController();
  void _postNote() {
    if (_controller.text != '') GoogleApi.insert(_controller.text);
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleApi.loading == true) {
      startLoading();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "P O S T N O T E",
          style: TextStyle(color: Color.fromARGB(255, 156, 134, 134)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[300],
      body: Column(children: [
        Expanded(
            child: Container(
          // ignore: prefer_const_constructors
          child: GoogleApi.loading == true ? MyLoading() : NotesGrid(),
        )),
        // ignore: prefer_const_constructors

        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: 'enter..',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                        },
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(' @ c r e a t e d b y m  a s h'),
                  Button(text: 'P O S T', function: _postNote),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
