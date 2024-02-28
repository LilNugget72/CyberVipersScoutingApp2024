import 'package:cyberviperscoutingapp2024/controllers/google_sheets_api.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/stats_page/read_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const ScoutingApp());
}

UserTheme ut = Get.put(UserTheme());
SheetValues sv = Get.put(SheetValues());

loadAllEvents({required RxBool finished}) async {
  // makes sure you have a connection with the sheet
  //calls for the initialization meathod for the sheet
  await GoogleSheetsApi().init();
  // https://fluttercentral.com/Articles/Post/1242/How_to_the_set_change_status_bar_or_system_navigation_bar_color_in_Flutter
  //THE LORD HAS CLUTCHED
  //the line under this waits for the screen size to be init
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  List listOfRegionals = [];
  List listOfDistricts = [];
  var regtionalEvents = await getAllRegionalEvents();
  var districtEvents = await getAllDistrictEvents();
  sv.regionalEvents.value = regtionalEvents;
  sv.districtEvents.value = districtEvents;
  listOfRegionals = regtionalEvents.keys.toList();
  listOfDistricts = districtEvents.keys.toList();
  listOfRegionals.sort();
  listOfDistricts.sort();
  sv.regionalEventsKeys.value = listOfRegionals;
  sv.districtEventKeys.value = listOfDistricts;
  sv.events.value = sv.regionalEventsKeys;
  Future.delayed(const Duration(seconds: 2));
  Get.to(() => const HomePage());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool finished = false.obs;
    loadAllEvents(finished: finished);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 220.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                height: 200.h,
                image:
                    const AssetImage("lib/assets/Cyber Vipers Logo 2023.png"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.h),
                child: const Text(
                  "Cyber Vipers Scouring App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSans',
                      fontSize: 25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ScoutingApp extends StatelessWidget {
  const ScoutingApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ut.bars,
        systemNavigationBarColor: Colors.grey[850],
        statusBarBrightness: ut.statbright));
    return ScreenUtilInit(
      builder: (_, child) => Obx(
        () => SafeArea(
          child: GetMaterialApp(
            theme: ut.currentTheme.value,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
      designSize: const Size(360, 800),
    );
  }
}
