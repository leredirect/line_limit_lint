import 'package:example/nice_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget of an app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NiceWidget(),
    );
  }
}
