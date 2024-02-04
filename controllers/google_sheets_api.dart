import 'package:cyberviperscoutingapp2024/controllers/user.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credential
  static const String _credentials = r'''
{
  "type": "service_account",
  "project_id": "cyber-vipers-spread-sheet",
  "private_key_id": "cb8e866e2ad742acdd53caba83494aaa76485394",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDnwoEi15asNjhf\nJFWQ/F1auF8J4G2IK1ktXaDf/f8LxXomuPW3Z67nng+E2lbfR/ZZJCcIbD0iimLb\nEGnNW5Qvp0Ye0Mi3AGlGFrIIlVEwqNByGGdfeefGLxAhEzLq618ErQSITmD6rh7L\nhXdV5N+0qysqA+JCg5un2vlpgy//j90gxSCsffUg5Nlher87vfzryqz1Zw3UaBRL\nrtRu7JgTy/qYAa5ARykByzk7ReBYncc80jastyXxNcuRuGvVpdxpHfvz21sl5owl\nxBtB9siXnT6by/sQsxt+Pvx1ggvcI9bobUNYlOV89cDt54DiNKlUI1CTe7mXjD/9\ns4GYyb/1AgMBAAECggEAH6WCprRTob5hojQ+7uZXBQ1KBPo9Wqu4qKYxUoTHb98O\nV/1HqDyjOINv0Q9Tb3fPHsr9/XtyOaY1633pRJ5ttLgdrhWKYtrOhUCSHPPuuztC\nA2JrszDdQkWo6StK96MePXA2vzocqf5evCHEctkm5u+8nCcdnUGFXr1a81pzkmzb\nDEbgWbujL1UdpwPwTwmfpCRKyBxjrVHWUR7u6tGNzwP3imL6IIgy0UtLSeZSE5dh\nAMp5HEWcwe6tJmdCZtokoJrxH5+dD+d1aRlpgf3L//seHAQy0MXstSefwiSjZzUx\nvZuuci7zGDcu70by0vzJnlMYqmIOgAhY+hurqMkP/QKBgQD9wqSCNcKvmtcdAF3U\nJgbXaHcgJ1dtveLOfvs35Bp1YjkYP1Fy62fPfUwOS+Z8IhJQwZRri3P1JEATF04p\nbCHi3NqyXfsT+HHcNnbJK9+XKKu80Uy8CviTRBH6UI/BEnJRLg2TIE5XyrcAtwOX\nJuF4Bqt9j/lEG4+FnunN0JDBswKBgQDpzicfk4nmJnh3olGo1S5UonsWIijOH82S\nYWt+SJyfktQBX9qVV3607hSQI7SGdSbHhNbtWcSxDorQyp26adfdNL03YCHEdZ1/\n8hT6HA+G29+uumH8iqRgfZA35xZ2u1+CRbRGwFh7WtDIcJ8j1V43pmn6nryXPMy5\n16HNg9UTtwKBgCtN/CT8Z6zwD6WzWk/J7YD1It8p15GyxfHXWafAFYPSr0ukApJJ\n+f0+tKv75+lnJxkA8AMqWS+McCLR51TKTz4X0np970sJKuUZpkvOYOm61xPx49Zz\nSNhY1XiSJvYb38ZaxZZF/RieT3yfvs0cpX2GJd3XpAIrceKrq9qjrRBhAoGAZckE\nyT9e0l4/Jb35lOmx8NCHi1w1rX607RwSQvjzjpjKSQrkyw07MSNQumuA5ORNjKCt\nPMlO0tIE5t6+ifAYNMoH8fqc2L1nYtMOBNCAhfJkz9l+XQYyh3tCdMPayLfL3Zfg\n4shL/O/NYuV8sonqKYn+K0g9zA2BBwrz+teAxMMCgYEArdhuzVlRk+mNJS0oZ2ww\nRdbRh8iXQYX6J0eUIz8cblTY93OkMN9Bt3oto9MY144e11HxzJ01dOuLEG+6zwyy\nXXEKW7GsS53lIeXj0NhKS/kjSTSepS5HpNuj0ljZelN2VXS4hFZtK843i77KJtSG\nnXAERG7K1ySx9lNHNvpYMjY=\n-----END PRIVATE KEY-----\n",
  "client_email": "cybervipersheet@cyber-vipers-spread-sheet.iam.gserviceaccount.com",
  "client_id": "103450218639815618184",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cybervipersheet%40cyber-vipers-spread-sheet.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

''';
// set up and connect to the speradsheet
// you can find the id in the middle of the URL of the spreadsheet
  static const _spreadsheetId = '1LguA3zZWvRQslDV3DPmQYuCyK7wlquIiPx8Gkq_XoA4';
  // the google sheet your connecting to. you have to pass the credentials
  static final _gsheets = GSheets(_credentials);
  // the worksheet is just the tabs in a google sheet
  static Worksheet? _worksheet;

  // we make this function to initialize the spreadsheet
  Future init() async {
    // calls for the spreadsheet
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    // calls for the worksheet inside the spreadsheet
    _worksheet = ss.worksheetByTitle('Main');

    // as stated this gets the fields of the worksheet.
    final firstRow = UserFields.getFields();
    //You have to pass what row your data starts in and then show it that values that will go with the corrisponding column
    _worksheet!.values.insertRow(1, firstRow);
  }

  /*This is kinda complicated but essntially its takes a List of a Map that has a string as its key and any type of variabe as its value
  all that is stored in the variable dataList but it can be called anything obviously
  When we send data we need to pass in the key and its corrisponding value
  The key is the colum on the sheet that we want to put the data in
  the value is just any kind of variable like an int or a bool
  all this does is make a new row everytime its called so long as there is at least one value passed(dont worry about that though)
  // It makes a new row then passes the values into the corrisponding spot(column)*/
  static Future sendData(List<Map<String, dynamic>> dataList) async {
    _worksheet!.values.map.appendRows(dataList);
  }
}
