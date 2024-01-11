import 'dart:convert';

class TeamMatchInfoModel {
  final Filters filters;
  final ResultSet resultSet;
  final List<Matches> matches;

  TeamMatchInfoModel({
    required this.filters,
    required this.resultSet,
    required this.matches,
  });

  factory TeamMatchInfoModel.fromJson(Map<String, dynamic> json) {
    var matchesFromJson = json['matches'] as List;
    List<Matches> matchesList =
        matchesFromJson.map((i) => Matches.fromJson(i)).toList();

    return TeamMatchInfoModel(
      filters: Filters.fromJson(json['filters']),
      resultSet: ResultSet.fromJson(json['resultSet']),
      matches: matchesList,
    );
  }
}

class Filters {
  final String competitions, permission;
  final int limit;

  Filters(
      {required this.competitions,
      required this.permission,
      required this.limit});

  factory Filters.fromJson(Map<String, dynamic> json) {
    return Filters(
      competitions: json['competitions'],
      permission: json['permission'],
      limit: json['limit'],
    );
  }
}

class ResultSet {
  final int count;
  final String competitions;
  final String first;
  final String last;
  final int played;
  final int wins;
  final int draws;
  final int losses;

  ResultSet({
    required this.count,
    required this.competitions,
    required this.first,
    required this.last,
    required this.played,
    required this.wins,
    required this.draws,
    required this.losses,
  });

  factory ResultSet.fromJson(Map<String, dynamic> json) {
    return ResultSet(
      count: json['count'],
      competitions: json['competitions'],
      first: json['first'],
      last: json['last'],
      played: json['played'],
      wins: json['wins'],
      draws: json['draws'],
      losses: json['losses'],
    );
  }
}

class Matches {
  final String utcDate;
  final String status;
  final int matchday;
  final HomeTeam homeTeam;
  final AwayTeam awayTeam;

  Matches({
    required this.utcDate,
    required this.status,
    required this.matchday,
    required this.homeTeam,
    required this.awayTeam,
  });

  factory Matches.fromJson(Map<String, dynamic> json) {
    return Matches(
      utcDate: json['utcDate'],
      status: json['status'],
      matchday: json['matchday'],
      homeTeam: HomeTeam.fromJson(json['homeTeam']),
      awayTeam: AwayTeam.fromJson(json['awayTeam']),
    );
  }
}

class HomeTeam {
  final int id;
  final String name, shortName, tla, crest;

  HomeTeam({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
  });

  factory HomeTeam.fromJson(Map<String, dynamic> json) {
    return HomeTeam(
      id: json['id'],
      name: json['name'],
      shortName: json['shortName'],
      tla: json['tla'],
      crest: json['crest'],
    );
  }
}

class AwayTeam {
  final int id;
  final String name, shortName, tla, crest;

  AwayTeam({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
  });

  factory AwayTeam.fromJson(Map<String, dynamic> json) {
    return AwayTeam(
      id: json['id'],
      name: json['name'],
      shortName: json['shortName'],
      tla: json['tla'],
      crest: json['crest'],
    );
  }
}
