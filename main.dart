import 'package:cyberviperscoutingapp2024/controllers/google_sheets_api.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/read_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  // makes sure you have a connection with the sheet
  //calls for the initialization meathod for the sheet
  await GoogleSheetsApi().init();
  // https://fluttercentral.com/Articles/Post/1242/How_to_the_set_change_status_bar_or_system_navigation_bar_color_in_Flutter
  //THE LORD HAS CLUTCHED
  //the line under this waits for the screen size to be init
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ScoutingApp());
}

UserTheme ut = Get.put(UserTheme());
SheetValues sv = Get.put(SheetValues());

class Loading extends GetxController {
  loadingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('HI'),
      ),
      body: LoadingAnimationWidget.beat(color: Colors.white, size: 100),
    );
  }
}

loadRegionalEvents() async {
  List listOfRegionals = [];
  List listOfDistricts = [];
  var regtionalEvents = await getAllRegionalEvents();
  var districtEvents = await getAllDistrictEvents();
  sv.regionalEvents.value = regtionalEvents;
  sv.districtEvents.value = districtEvents;
  listOfRegionals = regtionalEvents.keys.toList();
  listOfDistricts = districtEvents.keys.toList();
  sv.regionalEventsKeys.value = listOfRegionals;
  sv.districtEventKeys.value = listOfDistricts;
}

class ScoutingApp extends StatelessWidget {
  const ScoutingApp({super.key});

  @override
  Widget build(BuildContext context) {
    loadRegionalEvents();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ut.bars,
        systemNavigationBarColor: Colors.grey[850],
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
