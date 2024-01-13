import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfootball/services/api_service.dart';
import 'package:myfootball/models/team_match_info_model.dart';
import 'package:myfootball/widgets/match_info.dart';

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
    futureTeamMatchInfoModel = ApiService.getMatchInfo(widget.teamId);
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.teamId}");
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
          padding: const EdgeInsets.all(20),
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
              FutureBuilder<TeamMatchInfoModel>(
                future: futureTeamMatchInfoModel,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("오류가 발생했습니다.");
                  } else {
                    List<Widget> matchWidgets = [];
                    for (var match in snapshot.data!.matches) {
                      matchWidgets.add(MatchInfo(matches: match));
                    }
                    return Column(
                      children: matchWidgets,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
