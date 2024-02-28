import 'package:cyberviperscoutingapp2024/admin_auth.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:cyberviperscoutingapp2024/stats_page/read_sheet.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/manual_function.dart';
import 'package:cyberviperscoutingapp2024/stats_page/stats_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReuseWid extends GetxController {
  RxInt selectedIndex = 0.obs;
  UserTheme ut = Get.find();
  SheetValues sv = Get.put(SheetValues());
  TextEditingController event = TextEditingController();

  textForGraph({required String name}) {
    return Text(
      name,
      style: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: 18,
          color: ut.tt.value,
          letterSpacing: 1.6),
    );
  }

  line() {
    return Container(
      height: 1.5,
      color: ut.tt.value,
    );
  }

  teaminfo() {
    return Center(
      child: Text(
        'Team ${sv.teamNum} - Match ${sv.matchNum}',
        style:
            TextStyle(fontFamily: 'NotoSans', color: ut.tt.value, fontSize: 25),
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
                style: TextStyle(
                    fontSize: 25, color: ut.tt.value, fontFamily: 'NotoSans')),
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
      required Rx<Color> fillColor,
      required Color textColor}) {
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(18.r),
      onTap: () {
        if (value.value == true) {
          value.value = false;
          fillColor.value = Colors.transparent;
          textColor = ut.tt.value;
        } else {
          value.value = true;
          fillColor.value = ut.buttonColor.value;
          textColor = Colors.white;
        }
        print(textColor);
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
              style: TextStyle(
                  color: textColor, fontSize: 30, fontFamily: 'NotoSans'),
            ),
          ),
        ),
      ),
    );
  }

  toggleEventType() {
    String tapForDistricts = 'Tap to see District Events';
    String tapForRegionals = 'Tap to see Regional Events';
    RxString eventHint = 'Tap to see District Events'.obs;
    String regionalListHint = 'Select Regional';
    String districtListHint = 'Select District ';

    return ElevatedButton(
      onPressed: () {
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
      style: const ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(15, 16, 0, 16)),
          backgroundColor: MaterialStatePropertyAll(Color(0x00FFFFFF)),
          splashFactory: InkSplash.splashFactory,
          overlayColor:
              MaterialStatePropertyAll(Color.fromARGB(225, 176, 171, 171)),
          elevation: MaterialStatePropertyAll(0)),
      child: Obx(
        () => Center(
          child: Text(
            eventHint.value,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'NotoSans', fontSize: 20),
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
          drawerWid(
            title: 'About',
            function: () async {},
            icon: Icon(
              Icons.info_outline,
              color: ut.tt.value,
              size: 35,
            ),
          ),
          // drawerWid(
          //   title: 'Admin',
          //   function: () {
          //     if (sv.selectedAnEvent.isTrue) {
          //       Get.to(() => const AdminAuth());
          //     } else {
          //       noEvent.value = Colors.red;
          //     }
          //   },
          //   icon: Icon(
          //     Icons.person,
          //     color: ut.tt.value,
          //     size: 35,
          //   ),
          // ),
          // drawerWid(
          //   title: 'Manual',
          //   function: () {
          //     if (sv.selectedAnEvent.isTrue) {
          //       Get.to(() => const ManualPage());
          //     } else {
          //       noEvent.value = Colors.red;
          //     }
          //   },
          //   icon: Icon(
          //     Icons.add_circle_outline_rounded,
          //     color: ut.tt.value,
          //     size: 35,
          //   ),
          // ),
          // drawerWid(
          //   title: 'Update?',
          //   function: () => print('update'),
          //   icon: Icon(
          //     Icons.update,
          //     color: ut.tt.value,
          //     size: 35,
          //   ),
          // ),
          line(),
          toggleEventType(),
          Obx(
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
                sv.eventListHint.value = value!;
                if (sv.isDistrict.isFalse) {
                  sv.eventKey.value = sv.regionalEvents[value];
                } else {
                  sv.eventKey.value = sv.districtEvents[value];
                }
                noEvent.value = Colors.white;
                sv.selectedAnEvent.value = true;

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
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: const Text(
                  'Version 1.0',
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
      backgroundColor: Colors.transparent,
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
              Get.off(() => const StatsPage());
            }
        }
      },
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: 'Home',
            backgroundColor: Colors.grey[850]),
        BottomNavigationBarItem(
            icon: const Icon(Icons.content_paste),
            label: 'Scout',
            backgroundColor: Colors.grey[850]),
        BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart_outlined),
            label: 'Stats',
            backgroundColor: Colors.grey[850]),
      ],
    );
  }
}
