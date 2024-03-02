import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:cyberviperscoutingapp2024/stats_page/read_sheet.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

toggleEventType() {
  String tapForDistricts = 'Tap to see District Events';
  String tapForRegionals = 'Tap to see Regional Events';
  RxString eventHint = 'Tap to see District Events'.obs;
  String regionalListHint = 'Select Regional';
  String districtListHint = 'Select District ';

  return InkWell(
    borderRadius: BorderRadius.circular(20.r),
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
          borderRadius: BorderRadius.circular(20.r)),
      width: 300.w,
      height: 60.h,
      child: Center(
        child: Obx(
          () => Text(
            eventHint.value,
            style: const TextStyle(
                fontSize: 25, fontFamily: 'NotoSans', color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SheetValues sv = Get.find();
    UserTheme ut = Get.find();

    Rx<Color> noEvent = Colors.white.obs;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Welcome!',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'NotoSans',
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          SizedBox(
            width: 190.w,
            child: Obx(
              () => TextField(
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
                        color: ut.ts.value,
                        fontFamily: 'NotoSans',
                        fontSize: 20),
                  )),
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
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: 110.w,
            child: Obx(
              () => TextField(
                autocorrect: false,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                controller: sv.scoutersTeam,
                textAlign: TextAlign.center,
                enabled: true,
                cursorColor: Colors.white,
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'NotoSans', fontSize: 20),
                decoration: InputDecoration(
                  label: Center(
                    child: Text(
                      'Team #',
                      style: TextStyle(
                          color: ut.ts.value,
                          fontFamily: 'NotoSans',
                          fontSize: 20),
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
          ),
          SizedBox(
            height: 20.h,
          ),
          toggleEventType(),
          SizedBox(
            height: 20.h,
          ),
          Center(
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
                    maxHeight: 350.h,
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
            ),
          ),
          if (!isKeyboard)
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: GestureDetector(
                  onTap: () {
                    if (sv.scoutName.text.isEmpty ||
                        sv.scoutersTeam.text.isEmpty ||
                        sv.selectedAnEvent.isFalse) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          showCloseIcon: true,
                          backgroundColor: Colors.grey[800],
                          content: const Text(
                            'Fill in All Values',
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      );
                    } else {
                      sv.firstBoot.write('scouters name', sv.scoutName.text);
                      sv.firstBoot.write('scouters team', sv.scoutersTeam.text);
                      sv.firstBoot.write('event key', sv.eventKey.value);
                      sv.firstBoot
                          .write('selected event name', sv.eventListHint.value);
                      sv.firstBoot
                          .write('selected event?', sv.selectedAnEvent.value);
                      sv.firstBoot.write('booted', true);
                      Get.off(() => const HomePage());
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20.r)),
                    width: 250.w,
                    height: 60.h,
                    child: const Center(
                      child: Text(
                        'LETS GET SCOUTING',
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'NotoSans',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ))
        ],
      ),
    );
  }
}
