import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfootball/models/team_match_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MatchInfo extends StatefulWidget {
  const MatchInfo({
    super.key,
    required this.matches,
  });

  final Matches matches;

  @override
  State<MatchInfo> createState() => _MatchInfoState();
}

class _MatchInfoState extends State<MatchInfo> {
  bool isChecked = false;
  late int matchId;

  Future<void> setSwitchState(int key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key.toString(), value);
  }

// 값을 불러오는 함수
  Future<bool> getSwitchState(int key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key.toString()) ?? false;
    return value;
  }

  @override
  void initState() {
    super.initState();
    matchId = widget.matches.id;
    getSwitchState(matchId).then((value) {
      setState(() {
        isChecked = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String homeTeamName = widget.matches.homeTeam.shortName;
    String awayTeamName = widget.matches.awayTeam.shortName;
    String homeTeamEmblem = widget.matches.homeTeam.crest;
    String awayTeamEmblem = widget.matches.awayTeam.crest;
    String utcDate = widget.matches.utcDate;

    DateTime dateTime = DateTime.parse(utcDate).toLocal();
    String formattedString = DateFormat('yyyy년 MM월 dd일 HH:mm').format(dateTime);

    return GestureDetector(
      child: Container(
        height: 90,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(5, 5),
                color: Colors.black.withOpacity(0.2),
              ),
            ],
            border: Border.all(
              color: Colors.blue.shade400,
            ),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Switch(
                          value: isChecked,
                          onChanged: (value) async {
                            setState(() {
                              isChecked = value!;

                              print("check the switch!!");
                            });
                            await setSwitchState(matchId, isChecked);
                          }),
                      Container(
                        height: 30,
                        width: 30,
                        child: homeTeamEmblem.endsWith('.svg')
                            ? SvgPicture.network(
                                homeTeamEmblem,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                homeTeamEmblem,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(width: 8), //간격을 주기 위한 SizedBox
                      Text(
                        homeTeamName,
                        style: TextStyle(
                          color: Colors.blue.shade400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        awayTeamName,
                        style: TextStyle(
                          color: Colors.blue.shade400,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 30,
                        width: 30,
                        child: awayTeamEmblem.endsWith('.svg')
                            ? SvgPicture.network(
                                awayTeamEmblem,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                awayTeamEmblem,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                child: Text(
                  "$formattedString",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
