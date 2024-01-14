import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myfootball/widgets/team_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 25, 25),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Color.fromARGB(255, 31, 31, 33),
        foregroundColor: Colors.blue,
        title: const Text(
          "팀을 선택해주세요.",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: TeamListWidget(),
    );
  }
}
