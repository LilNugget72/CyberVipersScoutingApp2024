import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getCellValueInColumn(
    {required String columnName,
    required int rowNumber,
    required String team}) async {
  const String sheetId = '1LguA3zZWvRQslDV3DPmQYuCyK7wlquIiPx8Gkq_XoA4';
  const String apiKey = 'AIzaSyBpYucL1FQXNeAQQLvR0msikxLP0-sWS6k';
  final Uri uri = Uri.parse(
      'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$team?key=$apiKey');

  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final values = data['values'];

      if (values != null && values.length > 1) {
        final List<String> headers = values[0].cast<String>();
        final columnIndex = headers.indexOf(columnName);

        if (columnIndex != -1 && rowNumber >= 1 && rowNumber < values.length) {
          final List<dynamic> row = values[rowNumber];

          if (columnIndex < row.length && row[columnIndex] != null) {
            return row[columnIndex].toString();
          }
        }
      }
    }
  } catch (e) {
    // Handle any errors
  }

  return 'empty'; // Return empty string if cell value is not found or if an error occurred
}
