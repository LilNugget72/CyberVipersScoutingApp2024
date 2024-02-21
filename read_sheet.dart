// credit to ChatGPT version 3.5
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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

// Function to fetch values in batches
Future<List<String>> fetchValuesInBatches(String column, int team) async {
  final String teamString = team.toString();
  List<String> values = [];
  int i = 1;
  while (true) {
    var value = await getCellValueInColumn(
      rowNumber: i,
      columnName: column,
      team: teamString,
    );
    if (value == 'empty') break;
    values.add(value);
    i++;
  }
  return values;
}

// Function to calculate total value in list
Future<int> totalValueInList(String column, int team) async {
  List<String> values = await fetchValuesInBatches(column, team);
  int total = 0;
  for (String value in values) {
    total += int.tryParse(value) ?? 0;
  }
  return total;
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

// except this
Future<Map<int, String>> eventTeams(String eventKey) async {
  const String apiKey =
      'N2Qk9rnQmy2tPsqr9pWsefid1wGUM7sKZgstXWGaj2W9hYr8I7XMu3y3tGF0FYiF	';
  final String apiUrl =
      'https://www.thebluealliance.com/api/v3/event/$eventKey/teams';
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

class Trying extends StatelessWidget {
  const Trying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxInt made = 0.obs;
    RxInt missed = 0.obs;
    RxInt total = 0.obs;
    RxInt val = 0.obs;
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              int x = await countTotalValues('ROBOT AMP POSITION', 8717);
              int y = await countTrueValues('ROBOT AMP POSITION', 8717);
              int z = await totalValueInList('AUTO AMP NOTES', 8717);

              made.value = y;
              missed.value = x - y;
              total.value = x;

              val.value = z;
            },
            child: Container(
              color: Colors.amber,
              width: 100,
              height: 100,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Container(
                  width: 100.w,
                  height: 50.h,
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      made.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Container(
                  width: 100.w,
                  height: 50.h,
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      missed.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Container(
                  width: 100.w,
                  height: 50.h,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      total.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Container(
                  width: 50.w,
                  height: 50.h,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      val.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
