import 'package:flutter/material.dart';
import 'package:it_del/FirstScreen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(), // Your root widget
    );
  }
}
