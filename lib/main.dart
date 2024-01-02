import 'package:flutter/material.dart';

import 'GameScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
      debugShowCheckedModeBanner: false, //remove debug banner

    );
  }
}

