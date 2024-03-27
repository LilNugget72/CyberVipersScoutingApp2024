import 'package:cyberviperscoutingapp2024/controllers/google_sheets_api.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/stats_page/read_sheet.dart';
import 'package:cyberviperscoutingapp2024/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const ScoutingApp());
}

UserTheme ut = Get.put(UserTheme());
SheetValues sv = Get.put(SheetValues());

loadAllEvents({required RxBool finished}) async {
  bool canBoot = true;
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

  if (sv.pref.read('booted') == true) {
    sv.scoutName.text = sv.pref.read('scouters name');
    sv.scoutersTeam.text = sv.pref.read('scouters team');
    sv.eventKey.value = sv.pref.read('event key');
    sv.eventListHint.value = sv.pref.read('selected event name');

    sv.selectedAnEvent.value = sv.pref.read('selected event?');

    if (sv.pref.read('team only data') == true ||
        sv.pref.read('team only data') == false) {
      sv.wantsTeamOnlyStats.value = sv.pref.read('team only data');
      sv.wantsTeamOnlyStats.value == true
          ? sv.switchIcon.value = sv.switchIcon2
          : sv.switchIcon.value = sv.switchIcon1;
      canBoot = true;
    } else {
      canBoot = false;
    }

    var blueMatches = await blueAllianceTeams();
    var sortedBlue = blueMatches.keys.toList();
    sortedBlue.sort();
    sv.blueAllianceMatchesKeys.value = sortedBlue;
    sv.blueAllianceMatches.value = blueMatches;

    var redMatches = await redAllianceTeams();
    var sortedRed = redMatches.keys.toList();
    sortedRed.sort();
    sv.redAllianceMatchesKeys.value = sortedRed;
    sv.redAllianceMatches.value = redMatches;

    var thing = await eventTeams();
    var sortTeamList = thing.keys.toList();
    sortTeamList.sort();
    sv.teamXList.value = sortTeamList;
    sv.eventTeams.value = thing;

    if (canBoot == true) {
      Get.off(() => const HomePage());
    } else {
      Get.off(() => const WelcomePage());
    }
  } else {
    Get.off(() => const WelcomePage());
  }
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
                height: 220.h,
                image:
                    const AssetImage("lib/assets/Cyber Vipers Logo 2023.png"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.h),
                child: const Text(
                  "Ssscouting App",
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.grey[850],
        systemNavigationBarColor: Colors.grey[850],
      ),
    );
    //TODO safe aread and make the 360,800 and move padding
    return ScreenUtilInit(
      builder: (_, child) => SafeArea(
        child: GetMaterialApp(
          theme: ut.currentTheme,
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
      designSize: const Size(360, 800),
    );
  }
}
