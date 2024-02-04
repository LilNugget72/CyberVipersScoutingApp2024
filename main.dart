import 'package:cyberviperscoutingapp2024/controllers/google_sheets_api.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  // makes sure you have a connection with the sheet
  WidgetsFlutterBinding.ensureInitialized();
  //calls for the initialization meathod for the sheet
  GoogleSheetsApi().init();
  // https://fluttercentral.com/Articles/Post/1242/How_to_the_set_change_status_bar_or_system_navigation_bar_color_in_Flutter
  //Does this working hard every day
  runApp(const ScoutingApp());
}

UserTheme ut = Get.put(UserTheme());

class ScoutingApp extends StatelessWidget {
  const ScoutingApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ut.bars,
        systemNavigationBarColor: ut.tt.value,
        statusBarBrightness: ut.statbright));
    return Obx(() => SafeArea(
          bottom: true,
          top: true,
          child: GetMaterialApp(
            theme: ut.currentTheme.value,
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          ),
        ));
  }
}
