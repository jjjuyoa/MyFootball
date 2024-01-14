import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfootball/screens/%08team_screen.dart';
import 'package:myfootball/services/api_service.dart';
import 'package:myfootball/models/match_model.dart';

class TeamListWidget extends StatefulWidget {
  @override
  _TeamListWidgetState createState() => _TeamListWidgetState();
}

class _TeamListWidgetState extends State<TeamListWidget> {
  late Future<MatchModel> futureMatchModel;

  @override
  void initState() {
    super.initState();
    futureMatchModel = ApiService.getMatchSample();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MatchModel>(
      future: futureMatchModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: snapshot.data!.standings[0].table.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TeamScreen(
                                emblem: snapshot
                                    .data!.standings[0].table[index].team.crest,
                                name: snapshot.data!.standings[0].table[index]
                                    .team.shortName,
                                teamId: snapshot
                                    .data!.standings[0].table[index].team.id,
                              )));
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 120,
                        width: 120,
                        child: snapshot
                                .data!.standings[0].table[index].team.crest
                                .endsWith('.svg')
                            ? SvgPicture.network(
                                snapshot
                                    .data!.standings[0].table[index].team.crest,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                snapshot
                                    .data!.standings[0].table[index].team.crest,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(snapshot.data!.standings[0].table[index].team.name),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
