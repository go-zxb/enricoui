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
        appBar: AppBar(title: const Text('Card Example')),
        body: MyCard(),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 1,
          onTap: (index) {},
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      //NavigationBar
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: '首页',
        ),
        NavigationDestination(
          icon: Icon(Icons.explore),
          label: '探索',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: '我的',
        ),
      ],
    );
  }
}
