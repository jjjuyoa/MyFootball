import 'package:flutter/material.dart';
import 'package:myfootball/screens/home_screen.dart';
import 'package:myfootball/services/api_service.dart';

void main() {
  // ApiService().getMatchSample();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
