// lib/main.dart
import 'package:flutter/material.dart';

import 'card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Card Example')),
        body: const MyCard(),
      ),
    );
  }
}
