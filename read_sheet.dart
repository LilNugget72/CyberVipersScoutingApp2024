// credit to ChatGPT version 3.5
import 'dart:convert';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

SheetValues sv = Get.find();

Future<String> getCellValueInColumn({
  required String columnName,
  required int rowNumber,
  required String team,
}) async {
  const String sheetId = '1LguA3zZWvRQslDV3DPmQYuCyK7wlquIiPx8Gkq_XoA4';
  const String apiKey = 'AIzaSyBpYucL1FQXNeAQQLvR0msikxLP0-sWS6k';
  final Uri uri = Uri.parse(
      'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$team?key=$apiKey');

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      final List? values = data?['values'];

      if (values == null || values.isEmpty) {
        return 'empty';
      }

      final List<String>? headers = values[0]?.cast<String>();
      final int columnIndex = headers?.indexOf(columnName) ?? -1;

      if (columnIndex == -1 || rowNumber < 1 || rowNumber >= values.length) {
        return 'empty';
      }

      final List<dynamic> row = values[rowNumber];

      if (columnIndex >= row.length || row[columnIndex] == null) {
        return 'empty';
      }

      return row[columnIndex].toString();
    }
  } catch (e) {
    print('Error fetching data: $e'); // Log the error for debugging
  }

  return 'empty';
}

Future<int> totalValueInList(
    {required String column, required int team}) async {
  try {
    int total = 0;
    int rowNumber = 1;

    while (true) {
      // Fetch the value from the specified column for the current row
      String value = await getCellValueInColumn(
        columnName: column,
        rowNumber: rowNumber,
        team: team.toString(),
      );

      // Break the loop if the value is empty
      if (value == 'empty') {
        break;
      }

      // Parse the value to an integer and add it to the total
      total += int.tryParse(value) ?? 0;

      // Move to the next row
      rowNumber++;
    }

    return total;
  } catch (e) {
    print('Error: $e'); // Handle any errors
    return 0; // Return 0 if an error occurs
  }
}

// Function to count true values in list
Future<int> countTrueValues(String column, int team) async {
  final String teamString = team.toString();
  int count = 0;
  int i = 1;
  while (true) {
    var value = await getCellValueInColumn(
      rowNumber: i,
      columnName: column,
      team: teamString,
    );
    if (value == 'empty') break;
    if (value == 'TRUE') count++;
    i++;
  }
  return count;
}

// Function to count total values in list
Future<int> countTotalValues(String column, int team) async {
  final String teamString = team.toString();
  int count = 0;
  int i = 1;
  while (true) {
    var value = await getCellValueInColumn(
      rowNumber: i,
      columnName: column,
      team: teamString,
    );
    if (value == 'empty') break;
    count++;
    i++;
  }
  return count;
}

Future<Map<String, dynamic>> matchNumAndValue({
  required int team,
  required String column,
}) async {
  String match = 'MATCH #';
  String teamString = team.toString();
  Map<String, dynamic> matchAndValue = {};
  int i = 1;

  while (true) {
    String matchNum = await getCellValueInColumn(
      columnName: match,
      rowNumber: i,
      team: teamString,
    );

    if (matchNum == 'empty') break;

    var value = await getCellValueInColumn(
      columnName: column,
      rowNumber: i,
      team: teamString,
    );
    matchAndValue[matchNum] = value;
    i++;
  }
  print(matchAndValue);

  return matchAndValue;
}

// except these functions
Future<List> getAllValuesFromAMatch() async {
  List<String> column = [
    'MATCH #', // value is 0
    'ROBOT AMP POSITION', // value is 1
    'ROBOT CENTER POSITION', // value is 2
    'ROBOT BETWEEN POSITION', // value is 3
    'ROBOT SOURCE POSITION', // value is 4
    'NOTE 1', // value is 5
    'NOTE 2', // value is 6
    'NOTE 3', // value is 7
    'NOTE 4', // value is 8
    'NOTE 5', // value is 9
    'NOTE 6', // value is 10
    'NOTE 7', // value is 11
    'NOTE 8', // value is 12
    'LEAVE', // value is 13
    'AUTO AMP NOTES', // value is 14
    'AUTO SPEAKER NOTES', // value is 15
    'TELEOP AMP NOTES', // value is 16
    'TELEOP AMP MISSED', // value is 17
    'TELEOP SPEAKER NOTES', // value is 18
    'TELEOP SPEAKER MISSED', // value is 19
    'NOTES IN TRAP', // value is 20
    'MISSED TRAP', // value is 21
    'LEFT STAGE', // value is 22
    'CENTER STAGE', // value is 23
    'RIGHT STAGE', // value is 24
    'NONE', // value is 25
    'SLIGHT', // value is 26
    'MODEST', // value is 27
    'GENEROUS', // value is 28
    'EXCLUSIVELY', // value is 29
    'ONSTAGE', // value is 30
    'PARK', // value is 31
    'HARMONY', // value is 32
    'COMMENTS', // value is 33
  ];

  int team = sv.teamNum.value;
  List listAllValuesInMatch = [];

  int row = 1;

  for (int i = 0; i < column.length; i++) {
    String value = await getCellValueInColumn(
      columnName: column[i],
      rowNumber: row,
      team: "8717",
    );
    if (value != 'empty') {
      listAllValuesInMatch.add(value);
    }
  }
  String comments = await getCellValueInColumn(
    columnName: column[33],
    rowNumber: row,
    team: sv.selectedTeamValue.toString(),
  );

  listAllValuesInMatch.add(comments);

  return listAllValuesInMatch;
}

Future<Map<int, String>> eventTeams() async {
  const String apiKey =
      'N2Qk9rnQmy2tPsqr9pWsefid1wGUM7sKZgstXWGaj2W9hYr8I7XMu3y3tGF0FYiF	';
  final String apiUrl =
      'https://www.thebluealliance.com/api/v3/event/2024${sv.eventKey}/teams/simple';
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

Future<Map<int, List<int>>> fetchRedAllianceTeams() async {
  const String apiKey =
      'N2Qk9rnQmy2tPsqr9pWsefid1wGUM7sKZgstXWGaj2W9hYr8I7XMu3y3tGF0FYiF	';
  final String apiUrl =
      'https://www.thebluealliance.com/api/v3/event/2024${sv.eventKey}/matches';
  Map<int, List<int>> redAllianceTeamsMap = {};

  try {
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
          redAllianceTeamsMap[matchNumber] = redTeams;
        }
      }
      return redAllianceTeamsMap;
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return {};
    }
  } catch (e) {
    print('Error fetching data: $e');
    return {};
  }
}

Future<Map<int, List<String>>> fetchBlueAllianceTeams() async {
  const String apiKey =
      'N2Qk9rnQmy2tPsqr9pWsefid1wGUM7sKZgstXWGaj2W9hYr8I7XMu3y3tGF0FYiF';
  final String apiUrl =
      'https://www.thebluealliance.com/api/v3/event/2024${sv.eventKey}/matches';
  Map<int, List<String>> blueAllianceTeamsMap = {};

  try {
    final response =
        await http.get(Uri.parse(apiUrl), headers: {'X-TBA-Auth-Key': apiKey});
    if (response.statusCode == 200) {
      final List<dynamic> matchesData = json.decode(response.body);
      for (var match in matchesData) {
        if (match['comp_level'] == 'qm') {
          int matchNumber = match['match_number'];
          List<String> redTeams =
              match['alliances']['blue']['team_keys'].cast<String>();
          blueAllianceTeamsMap[matchNumber] = redTeams;
        }
      }
      return blueAllianceTeamsMap;
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      return {};
    }
  } catch (e) {
    print('Error fetching data: $e');
    return {};
  }
}

Future<Map<String, String>> getAllRegionalEvents() async {
  const String apiKey =
      'N2Qk9rnQmy2tPsqr9pWsefid1wGUM7sKZgstXWGaj2W9hYr8I7XMu3y3tGF0FYiF';
  final String apiUrl =
      'https://www.thebluealliance.com/api/v3/events/2024/simple';
  Map<String, String> allEventsMap = {};

  try {
    final response =
        await http.get(Uri.parse(apiUrl), headers: {'X-TBA-Auth-Key': apiKey});
    if (response.statusCode == 200) {
      final List<dynamic> events = json.decode(response.body);
      for (var events in events) {
        final String eventName = events['name'];
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
  final String apiUrl =
      'https://www.thebluealliance.com/api/v3/events/2024/simple';
  Map<String, String> allEventsMap = {};

  try {
    final response =
        await http.get(Uri.parse(apiUrl), headers: {'X-TBA-Auth-Key': apiKey});
    if (response.statusCode == 200) {
      final List<dynamic> events = json.decode(response.body);
      for (var events in events) {
        final String eventName = events['name'];
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
