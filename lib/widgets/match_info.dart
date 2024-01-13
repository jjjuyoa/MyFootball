import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfootball/models/team_match_info_model.dart';

class MatchInfo extends StatelessWidget {
  const MatchInfo({
    super.key,
    required this.matches,
  });

  final Matches matches;

  @override
  Widget build(BuildContext context) {
    String homeTeamName = matches.homeTeam.shortName;
    String awayTeamName = matches.awayTeam.shortName;
    String homeTeamEmblem = matches.homeTeam.crest;
    String awayTeamEmblem = matches.awayTeam.crest;

    return GestureDetector(
      child: Container(
        height: 60,
        margin: EdgeInsets.only(bottom: 10),
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
                        SizedBox(width: 8), //간격을 주기 위한 SizedBox
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
              ],
            )),
      ),
    );
  }
}
