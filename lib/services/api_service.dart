import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myfootball/models/match_model.dart';

class ApiService {
  final String baseUrl = "https://api.football-data.org/v4";
  final String matchSample = "competitions/PL/standings";

  Future<MatchModel> getMatchSample() async {
    final url = Uri.parse('$baseUrl/$matchSample');
    final response = await http.get(
      url,
      headers: {'X-Auth-Token': 'a7069a7bc96a42a2b73ec49aa5346c3c'},
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print("parsing successes");
      return MatchModel.fromJson(jsonResponse);
    }
    print("$baseUrl/$matchSample");
    print(response.statusCode);
    throw Error();
  }
}
