import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:cyberviperscoutingapp2024/stats_page/read_sheet.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/manual_function.dart';
import 'package:cyberviperscoutingapp2024/stats_page/stats_fields.dart';
import 'package:cyberviperscoutingapp2024/stats_page/stats_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReuseWid extends GetxController {
  RxInt selectedIndex = 0.obs;
  UserTheme ut = Get.find();
  SheetValues sv = Get.put(SheetValues());
  StatsFields sf = Get.put(StatsFields());
  TextEditingController event = TextEditingController();

  textForGraph({required String name}) {
    return Text(
      name,
      style: const TextStyle(
          fontFamily: 'NotoSans',
          fontSize: 18,
          color: Colors.white,
          letterSpacing: 1.6),
    );
  }

  line() {
    return Container(
      height: 1.5,
      color: Colors.white,
    );
  }

  teaminfo() {
    return Center(
      child: Text(
        'Team ${sv.teamNum} - Match ${sv.matchNum}',
        style: const TextStyle(
            fontFamily: 'NotoSans', color: Colors.white, fontSize: 25),
      ),
    );
  }

  drawerWid({required String title, required function, required icon}) {
    return ElevatedButton(
      onPressed: function,
      style: const ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(15, 16, 0, 16)),
          backgroundColor: MaterialStatePropertyAll(Color(0x00FFFFFF)),
          splashFactory: InkSplash.splashFactory,
          overlayColor:
              MaterialStatePropertyAll(Color.fromARGB(225, 176, 171, 171)),
          elevation: MaterialStatePropertyAll(0)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(
            width: 12,
          ),
          Obx(
            () => Text(title,
                style: const TextStyle(
                    fontSize: 25, color: Colors.white, fontFamily: 'NotoSans')),
          ),
          const SizedBox(
            height: double.minPositive,
            width: double.minPositive,
          )
        ],
      ),
    );
  }

  valueToggle(
      {required RxBool value,
      required String title,
      required double width,
      required double height,
      required Rx<Color> fillColor}) {
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(18.r),
      onTap: () {
        if (value.value == true) {
          value.value = false;
          fillColor.value = Colors.transparent;
        } else {
          value.value = true;
          fillColor.value = ut.buttonColor.value;
        }
      },
      child: Obx(
        () => Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: ut.buttonColor.value, width: 4.w),
              color: fillColor.value),
          width: width,
          height: height,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: 'NotoSans'),
            ),
          ),
        ),
      ),
    );
  }

  statsType() {
    return Column(
      children: [
        const Text(
          'Team Only Data',
          style: TextStyle(
              color: Colors.white, fontFamily: 'NotoSans', fontSize: 25),
        ),
        Obx(
          () => Switch.adaptive(
            activeTrackColor: Colors.red,
            thumbIcon: sv.switchIcon.value,
            trackOutlineColor: const MaterialStatePropertyAll(Colors.white),
            value: sv.wantsTeamOnlyStats.value,
            onChanged: (value) {
              if (sv.wantsTeamOnlyStats.value == false) {
                sv.wantsTeamOnlyStats.value = true;
                sv.switchIcon.value = sv.switchIcon2;
              } else {
                sv.wantsTeamOnlyStats.value = false;

                sv.switchIcon.value = sv.switchIcon1;
              }
              sv.pref.write('team only data', sv.wantsTeamOnlyStats.value);
            },
          ),
        )
      ],
    );
  }

  toggleEventType() {
    String tapForDistricts = 'Tap to see District Events';
    String tapForRegionals = 'Tap to see Regional Events';
    RxString eventHint = 'Tap to see District Events'.obs;
    String regionalListHint = 'Select Regional';
    String districtListHint = 'Select District';

    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      splashColor: Colors.grey[350],
      splashFactory: InkRipple.splashFactory,
      onTap: () {
        if (sv.isDistrict.isFalse) {
          sv.isDistrict.value = true;
          eventHint.value = tapForRegionals;
          sv.events.value = sv.districtEventKeys;
          sv.eventListHint.value = districtListHint;
        } else {
          sv.isDistrict.value = false;
          eventHint.value = tapForDistricts;
          sv.events.value = sv.regionalEventsKeys;
          sv.eventListHint.value = regionalListHint;
        }
        sv.teamListHint.value = 'Select A Team To View';
        sv.selectedAnEvent.value = false;
      },
      child: Ink(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2.w),
            borderRadius: BorderRadius.circular(15.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          child: Obx(
            () => Text(
              eventHint.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 25, fontFamily: 'NotoSans', color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  d() {
    Rx<Color> noEvent = Colors.white.obs;
    return Drawer(
      backgroundColor: Colors.grey[800],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          toggleEventType(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18.h),
            child: Center(
              child: SizedBox(
                width: 200.w,
                child: Obx(
                  () => DropdownButton2(
                    underline: const SizedBox(),
                    isExpanded: true,
                    hint: Obx(
                      () => Text(
                        '      ${sv.eventListHint}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSans',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    onChanged: (value) async {
                      sv.matchAndRowNum.value = [];
                      sv.eventListHint.value = value!;
                      sv.selectMatch.value = 'Select a Match';
                      sf.clearView();
                      if (sv.isDistrict.isFalse) {
                        sv.eventKey.value = sv.regionalEvents[value];
                      } else {
                        sv.eventKey.value = sv.districtEvents[value];
                      }
                      noEvent.value = Colors.white;
                      sv.selectedAnEvent.value = true;

                      sv.pref.write('event key', sv.eventKey.value);
                      sv.pref
                          .write('selected event?', sv.selectedAnEvent.value);
                      sv.pref
                          .write('selected event name', sv.eventListHint.value);

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

                      sv.teamListHint.value = 'Select A Team To View';
                    },
                    items: sv.events
                        .map((dynamic event) => DropdownMenuItem<String>(
                              value: event,
                              child: Text(
                                event,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'NotoSans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                            ))
                        .toList(),
                    alignment: Alignment.center,
                    iconStyleData:
                        const IconStyleData(iconEnabledColor: Colors.white),
                    dropdownStyleData: DropdownStyleData(
                      scrollbarTheme: const ScrollbarThemeData(
                          thumbColor: MaterialStatePropertyAll(Colors.grey)),
                      maxHeight: 400.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r)),
                    ),
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                        border: Border.all(color: noEvent.value, width: 2),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: statsType(),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: const Text(
                  'Version 1.2',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'NotoSans',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ab({required String title}) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontSize: 25, fontFamily: 'NotoSans'),
      ),
    );
  }

  bnb() {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[850],
      iconSize: 28,
      elevation: 0,
      currentIndex: selectedIndex.value,
      onTap: (index) async {
        selectedIndex.value = index;
        switch (index) {
          case 0:
            Get.off(() => const HomePage());
          case 1:
            if (sv.scoutName.text.isBlank! || sv.scoutersTeam.isBlank!) {
              ut.tfc.value = Colors.red;
              await Future.delayed(const Duration(milliseconds: 250));
              ut.tfc.value = Colors.white;
              await Future.delayed(const Duration(milliseconds: 250));
              ut.tfc.value = Colors.red;
              await Future.delayed(const Duration(milliseconds: 250));
              ut.tfc.value = Colors.white;
            } else {
              Get.off(() => const ManualPage());
            }
          case 2:
            if (sv.selectedAnEvent.isTrue) {
              if (sv.alreadyInStats.isFalse) {
                sv.statsWantsBlue.value = true;
                ut.buttonColor.value = const Color.fromARGB(255, 0, 101, 179);
              }
              Get.to(() => const StatsPage());
            }
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.content_paste),
          label: 'Scout',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: 'Stats',
        ),
      ],
    );
  }

  nameField() {
    return SizedBox(
      width: 190.w,
      child: Obx(
        () => TextField(
          onChanged: (value) {
            sv.pref.write('scouters name', value);
          },
          autocorrect: false,
          controller: sv.scoutName,
          textAlign: TextAlign.center,
          enabled: true,
          cursorColor: Colors.white,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'NotoSans', fontSize: 20),
          decoration: InputDecoration(
            label: Center(
              child: Text(
                'Name',
                style: TextStyle(
                    color: ut.ts.value, fontFamily: 'NotoSans', fontSize: 20),
              ),
            ),
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide(color: ut.tfc.value, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide(color: ut.tfc.value, width: 2)),
          ),
        ),
      ),
    );
  }
}
