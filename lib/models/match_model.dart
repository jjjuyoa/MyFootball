import 'dart:convert';

//현재 시즌 EPL 팀의 모든 정보 Api로 받아오기
class MatchModel {
  final Filters filters;
  final Area area;
  final Competition competition;
  final Season season;
  final List<Standings> standings;

  MatchModel(
      {required this.filters,
      required this.area,
      required this.competition,
      required this.season,
      required this.standings});

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    var standingsFromJson = json['standings'] as List;
    List<Standings> standingsList =
        standingsFromJson.map((i) => Standings.fromJson(i)).toList();

    return MatchModel(
      filters: Filters.fromJson(json['filters']),
      area: Area.fromJson(json['area']),
      competition: Competition.fromJson(json['competition']),
      season: Season.fromJson(json['season']),
      standings: standingsList,
    );
  }
}

class Filters {
  final String season;

  Filters({required this.season});

  factory Filters.fromJson(Map<String, dynamic> json) {
    return Filters(
      season: json['season'],
    );
  }
}

class Area {
  final int id;
  final String name, code, flag;

  Area({
    required this.id,
    required this.name,
    required this.code,
    required this.flag,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      flag: json['flag'],
    );
  }
}

class Competition {
  final int id;
  final String name, code, type, emblem;

  Competition({
    required this.id,
    required this.name,
    required this.code,
    required this.type,
    required this.emblem,
  });

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      type: json['type'],
      emblem: json['emblem'],
    );
  }
}

class Season {
  final int id;
  final String startDate;
  final String endDate;
  final int currentMatchday;
  final dynamic
      winner; // 'winner' field could be null, so we use 'dynamic' type.
  final List<String> stages;

  Season(
      {required this.id,
      required this.startDate,
      required this.endDate,
      required this.currentMatchday,
      this.winner,
      required this.stages});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json['id'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      currentMatchday: json['currentMatchday'],
      winner: json['winner'],
      stages: json['stages'] != null
          ? List<String>.from(json['stages'].map((x) => x))
          : [],
    );
  }
}

class Standings {
  final String stage;
  final String type;
  final List<Table> table;

  Standings({required this.stage, required this.type, required this.table});

  factory Standings.fromJson(Map<String, dynamic> json) {
    var tableFromJson = json['table'] as List;
    List<Table> tableList =
        tableFromJson.map((i) => Table.fromJson(i)).toList();

    return Standings(
      stage: json['stage'],
      type: json['type'],
      table: tableList,
    );
  }
}

class Table {
  final int position;
  final Team team;
  final int playedGames;
  final int won;
  final int draw;
  final int lost;
  final int points;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;

  Table(
      {required this.position,
      required this.team,
      required this.playedGames,
      required this.won,
      required this.draw,
      required this.lost,
      required this.points,
      required this.goalsFor,
      required this.goalsAgainst,
      required this.goalDifference});

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      position: json['position'],
      team: Team.fromJson(json['team']),
      playedGames: json['playedGames'],
      won: json['won'],
      draw: json['draw'],
      lost: json['lost'],
      points: json['points'],
      goalsFor: json['goalsFor'],
      goalsAgainst: json['goalsAgainst'],
      goalDifference: json['goalDifference'],
    );
  }
}

class Team {
  final int id;
  final String name;
  final String shortName;
  final String tla;
  final String crest;

  Team(
      {required this.id,
      required this.name,
      required this.shortName,
      required this.tla,
      required this.crest});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      shortName: json['shortName'],
      tla: json['tla'],
      crest: json['crest'],
    );
  }
}
