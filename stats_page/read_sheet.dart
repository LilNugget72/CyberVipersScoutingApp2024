import 'dart:convert';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

SheetValues sv = Get.find();

// credit to read the sheet to ChatGPT version 3.5
Future<Map<String, List<String>>> getDataForMatchNumber({
  required String team,
}) async {
  const String sheetId = '1LguA3zZWvRQslDV3DPmQYuCyK7wlquIiPx8Gkq_XoA4';
  const String apiKey = 'AIzaSyBpYucL1FQXNeAQQLvR0msikxLP0-sWS6k';
  final Uri uri = Uri.parse(
      'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$team?majorDimension=ROWS&key=$apiKey');

  /*
  'ALLIANCE', // value is 0
    'MATCH #', // value is 1
    'ROBOT AMP POSITION', // value is 2
    'ROBOT CENTER POSITION', // value is 3
    'ROBOT BETWEEN POSITION', // value is 4
    'ROBOT SOURCE POSITION', // value is 5
    'NOTE 1', // value is 6
    'NOTE 2', // value is 7
    'NOTE 3', // value is 8
    'NOTE 4', // value is 10
    'NOTE 5', // value is 11
    'NOTE 6', // value is 12
    'NOTE 7', // value is 13
    'NOTE 8', // value is 14
    'LEAVE', // value is 15
    'AUTO AMP NOTES', // value is 16
    'AUTO SPEAKER NOTES', // value is 17
    'TELEOP AMP NOTES', // value is 18
    'TELEOP AMP MISSED', // value is 19
    'TELEOP SPEAKER NOTES', // value is 20
    'TELEOP SPEAKER MISSED', // value is 21
    'NOTES IN TRAP', // value is 22
    'MISSED TRAP', // value is 23
    'LEFT STAGE', // value is 24
    'CENTER STAGE', // value is 25
    'RIGHT STAGE', // value is 26
    'NONE', // value is 27
    'SLIGHT', // value is 28
    'MODEST', // value is 29
    'GENEROUS', // value is 30
    'EXCLUSIVELY', // value is 31
    'ONSTAGE', // value is 32
    'PARK', // value is 33
    'HARMONY', // value is 34
    'COMMENTS', // value is 35
    'SCOUTER'S NAME', // value is 36
    'SCOUTER'S TEAM', // value is 37
       */

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List? values = data['values'];

      if (values == null || values.isEmpty) {
        return {};
      }

      // Initialize the map to store match number and associated data
      Map<String, List<String>> matchDataMap = {};

      // Iterate through each row of data (starting from the second row)
      for (int i = 1; i < values.length; i++) {
        // Extract match number from the third value in the row
        String matchNumber = values[i][2].toString();

        // Retrieve the list of data associated with the match number
        List<String> rowData = values[i]
            .sublist(1)
            .map<String>((value) => value == null || value.toString().isEmpty
                ? 'NO VALUE PRESENT'
                : value.toString())
            .toList();

        // Store the data in the map
        matchDataMap[matchNumber] = rowData;
      }
      sv.matchNumAndValue.value = matchDataMap;
      List row = matchDataMap.keys.toList();
      sv.matchAndRowNum.value = row;
      return matchDataMap;
    }
  } catch (e) {
    print('Error fetching data: $e');
  }

  return {};
}

// except these functions below
String getAllAverageTrue({required int column}) {
  List matches = sv.matchAndRowNum;
  int listLength = sv.matchNumAndValue.length;
  int allTrue = 0;
  int total = 0;
  for (int i = 0; i < listLength; i++) {
    List values = sv.matchNumAndValue[matches[i]];
    String wantedValue = values[column];
    total++;
    if (wantedValue != '0' && wantedValue != 'FALSE') allTrue++;
  }
  return '$allTrue / $total';
}

String getMatchBool({required int column, required String match}) {
  List value = sv.matchNumAndValue[match];
  String wantedValue = value[column];
  return wantedValue;
}

double getAllAverageNumbers({required int made, required int missed}) {
  List allMatchNumbers = sv.matchAndRowNum;
  int totalMatches = sv.matchNumAndValue.length;
  int top = 0;
  int total = 0;
  double average;
  if (sv.matchNumAndValue.isNotEmpty) {
    for (int i = 0; i < totalMatches; i++) {
      var currentRow = sv.matchNumAndValue[allMatchNumbers[i]];
      int over = int.parse(currentRow[made]);
      int under = int.parse(currentRow[missed]);
      top += over;
      total += over + under;
    }
  }
  average = top / total;
  if (average.isNaN) {
    average = 0;
    return average;
  } else {
    return average.toPrecision(3);
  }
}

double getMatchAverageNumbers(
    {required int made, required int missed, required String match}) {
  int top = 0;
  int total = 0;
  double average;
  if (sv.matchNumAndValue.isNotEmpty) {
    var currentRow = sv.matchNumAndValue[match];
    int over = int.parse(currentRow[made]);
    int under = int.parse(currentRow[missed]);
    top += over;
    total += over + under;
  }
  average = top / total;
  print(average);
  if (average.isNaN) {
    return 0.0;
  } else {
    return average.toPrecision(3);
  }
}

Future<Map<int, String>> eventTeams() async {
  const String apiKey =
      'N2Qk9rnQmy2tPsqr9pWsefid1wGUM7sKZgstXWGaj2W9hYr8I7XMu3y3tGF0FYiF	';
  final String apiUrl =
      'https://www.thebluealliance.com/api/v3/event/2023${sv.eventKey}/teams/simple';
  Map<int, String> teamNames = {};

  final response =
      await http.get(Uri.parse(apiUrl), headers: {'X-TBA-Auth-Key': apiKey});

  if (response.statusCode == 200) {
    final List<dynamic> eventTeams = json.decode(response.body);

    for (var team in eventTeams) {
      final int teamNumber = team['team_number'];
      final String teamName = team['nickname'];
      teamNames[teamNumber] = teamName;
    }
    return teamNames;
  } else {
    print('Error: ${response.statusCode} - ${response.body}');
    return {};
  }
}

Future<Map<int, List<int>>> redAllianceTeams() async {
  const String apiKey =
      'N2Qk9rnQmy2tPsqr9pWsefid1wGUM7sKZgstXWGaj2W9hYr8I7XMu3y3tGF0FYiF	';
  final String apiUrl =
      'https://www.thebluealliance.com/api/v3/event/2023${sv.eventKey}/matches/simple';
  Map<int, List<int>> redAllianceTeams = {};

  final response =
      await http.get(Uri.parse(apiUrl), headers: {'X-TBA-Auth-Key': apiKey});
  if (response.statusCode == 200) {
    final List<dynamic> matchesData = json.decode(response.body);
    for (var match in matchesData) {
      if (match['comp_level'] == 'qm') {
        int matchNumber = match['match_number'];
        List<int> redTeams = match['alliances']['red']['team_keys']
            .map<int>((teamKey) => int.parse(teamKey.substring(3)))
            .toList();
        redAllianceTeams[matchNumber] = redTeams;
      }
    }
    return redAllianceTeams;
  } else {
    return {};
  }
}

Future<Map<int, List<int>>> blueAllianceTeams() async {
  const String apiKey =
      'N2Qk9rnQmy2tPsqr9pWsefid1wGUM7sKZgstXWGaj2W9hYr8I7XMu3y3tGF0FYiF	';
  final String apiUrl =
      'https://www.thebluealliance.com/api/v3/event/2024${sv.eventKey}/matches/simple';
  Map<int, List<int>> blueAllianceTeams = {};

  final response =
      await http.get(Uri.parse(apiUrl), headers: {'X-TBA-Auth-Key': apiKey});
  if (response.statusCode == 200) {
    final List<dynamic> matchesData = json.decode(response.body);
    for (var match in matchesData) {
      if (match['comp_level'] == 'qm') {
        int matchNumber = match['match_number'];
        List<int> redTeams = match['alliances']['blue']['team_keys']
            .map<int>((teamKey) => int.parse(teamKey.substring(3)))
            .toList();
        blueAllianceTeams[matchNumber] = redTeams;
      }
    }
    return blueAllianceTeams;
  } else {
    return {};
  }
}

Future<Map<String, String>> getAllRegionalEvents() async {
  const String apiKey =
      'N2Qk9rnQmy2tPsqr9pWsefid1wGUM7sKZgstXWGaj2W9hYr8I7XMu3y3tGF0FYiF';
  final String apiUrl = 'https://www.thebluealliance.com/api/v3/events/2024';
  Map<String, String> allEventsMap = {};

  try {
    final response =
        await http.get(Uri.parse(apiUrl), headers: {'X-TBA-Auth-Key': apiKey});
    if (response.statusCode == 200) {
      final List<dynamic> events = json.decode(response.body);
      for (var events in events) {
        final String eventName = events['short_name'];
        final String eventKey = events['event_code'];
        final int eventType = events['event_type'];
        if (eventType == 0) {
          allEventsMap[eventName] = eventKey;
        }
      }
      return allEventsMap;
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return {};
    }
  } catch (e) {
    print('Error fetching data: $e');
    return {};
  }
}

Future<Map<String, String>> getAllDistrictEvents() async {
  const String apiKey =
      'N2Qk9rnQmy2tPsqr9pWsefid1wGUM7sKZgstXWGaj2W9hYr8I7XMu3y3tGF0FYiF';
  final String apiUrl = 'https://www.thebluealliance.com/api/v3/events/2024';
  Map<String, String> allEventsMap = {};

  try {
    final response =
        await http.get(Uri.parse(apiUrl), headers: {'X-TBA-Auth-Key': apiKey});
    if (response.statusCode == 200) {
      final List<dynamic> events = json.decode(response.body);
      for (var events in events) {
        final String eventName = events['short_name'];
        final String eventKey = events['event_code'];
        final int eventType = events['event_type'];
        if (eventType == 1) {
          allEventsMap[eventName] = eventKey;
        }
      }
      return allEventsMap;
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return {};
    }
  } catch (e) {
    print('Error fetching data: $e');
    return {};
  }
}
