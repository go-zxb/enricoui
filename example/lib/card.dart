import 'package:enricoui/enricoui.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ECard(
      onTap: () {
        print('Card tapped');
      },
      cardColor: Colors.blue,
      shadowColor: Colors.black,
      borderRadius: 20,
      elevation: 5,
      height: 200,
      width: 300,
      gradient: const LinearGradient(
        colors: [Colors.blue, Colors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: const Center(child: Text('Hello, World!')),
    );
  }
}
