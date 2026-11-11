import 'package:flutter/material.dart';
import 'screens/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Near Hopital',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const MapScreen(),
    );
  }
}