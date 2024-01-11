import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfootball/services/api_service.dart';
import 'package:myfootball/models/team_match_info_model.dart';

class TeamScreen extends StatefulWidget {
  final String emblem, name;
  final int teamId;

  const TeamScreen({
    super.key,
    required this.emblem,
    required this.name,
    required this.teamId,
  });

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  late Future<TeamMatchInfoModel> futureTeamMatchInfoModel;

  @override
  void initState() {
    super.initState();
    futureTeamMatchInfoModel = ApiService.getMatchInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.teamId,
                    child: Container(
                      width: 250,
                      height: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: widget.emblem.endsWith('.svg')
                          ? SvgPicture.network(
                              widget.emblem,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              widget.emblem,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //여기가 경기 일정 들어갈 자리
            ],
          ),
        ),
      ),
    );
  }
}
