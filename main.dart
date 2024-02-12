import 'package:cyberviperscoutingapp2024/controllers/google_sheets_api.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  // makes sure you have a connection with the sheet
  WidgetsFlutterBinding.ensureInitialized();
  //calls for the initialization meathod for the sheet
  GoogleSheetsApi().init();
  // https://fluttercentral.com/Articles/Post/1242/How_to_the_set_change_status_bar_or_system_navigation_bar_color_in_Flutter
  //THE LORD HAS CLUTCHED
  //the line under this waits for the screen size to be init
  await ScreenUtil.ensureScreenSize();
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
    return ScreenUtilInit(
      builder: (_, child) => Obx(
        () => SafeArea(
          child: GetMaterialApp(
            theme: ut.currentTheme.value,
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
      designSize: const Size(360, 800),
    );
  }
}
