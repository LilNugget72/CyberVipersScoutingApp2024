import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/stats_page/read_sheet.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/auto_start.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

teamInMatch({
  required RxString text,
  required RxString teamNumber,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(20.r),
    splashColor: Colors.grey,
    onTap: () {
      if (text.isNotEmpty) {
        sv.teamNum.value = int.parse(text.value);
        int teamNum = sv.teamNum.value;
        teamNumber.value = teamNum.toString();
        String? teamName = sv.eventTeams[teamNum];
        if (teamName != null) {
          sv.teamName.value = teamName;
        } else {
          sv.teamName.value = 'No Team Found';
        }
      }
    },
    child: Container(
      width: 80.w,
      height: 60.h,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2.w),
          borderRadius: BorderRadius.circular(20.r)),
      child: Center(
        child: Obx(
          () => Text(
            text.value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'NotoSans',
              fontSize: 18,
            ),
          ),
        ),
      ),
    ),
  );
}

class ManualPage extends StatelessWidget {
  const ManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    SheetValues sv = Get.put(SheetValues());
    ReuseWid rw = Get.put(ReuseWid());

    RxString matchHint = 'Select a Match'.obs;
    RxList matches = [].obs;

    RxBool selectedBlueAlliance = false.obs;

    RxString team1 = ''.obs;
    RxString team2 = ''.obs;
    RxString team3 = ''.obs;

    RxString localAlliacne = ''.obs;
    RxString localMatch = ''.obs;
    RxString localTeam = ''.obs;

    return Scaffold(
      drawer: rw.d(),
      appBar: rw.ab(title: 'Scouting Page'),
      body: ListView(
        children: [
          rw.line(),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    if (sv.selectedAnEvent.isTrue) {
                      matches.value = sv.blueAllianceMatchesKeys;
                      matchHint.value = 'Blue Allaince Matches';
                      sv.alliance.value = 'Blue';
                      localAlliacne.value = 'Blue';
                      selectedBlueAlliance.value = true;
                      ut.buttonColor.value =
                          const Color.fromARGB(255, 0, 101, 179);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          showCloseIcon: true,
                          backgroundColor: Colors.grey[800],
                          content: const Text(
                            'No Event Selected',
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: const Color.fromARGB(255, 0, 101, 179),
                    ),
                    width: 150.w,
                    height: 100.h,
                    child: const Center(
                      child: Text(
                        'Tap to Scout the Blue Alliance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NotoSans',
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (sv.selectedAnEvent.isTrue) {
                      matches.value = sv.redAllianceMatchesKeys;
                      sv.alliance.value = 'Red';
                      localAlliacne.value = 'Red';
                      selectedBlueAlliance.value = false;
                      matchHint.value = 'Red Allaince Matches';
                      ut.buttonColor.value =
                          const Color.fromARGB(255, 237, 52, 52);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          showCloseIcon: true,
                          backgroundColor: Colors.grey[800],
                          content: const Text(
                            'No Event Selected',
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: const Color.fromARGB(255, 237, 52, 52),
                    ),
                    width: 150.w,
                    height: 100.h,
                    child: const Center(
                      child: Text(
                        'Tap to Scout the Red Alliance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NotoSans',
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: Center(
              child: SizedBox(
                width: 170.w,
                child: Obx(
                  () => DropdownButton2(
                    underline: const SizedBox(),
                    isExpanded: true,
                    hint: Obx(
                      () => Text(
                        matchHint.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSans',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      matchHint.value = 'Match $value';
                      sv.matchNum.value = value;
                      localMatch.value = value.toString();
                      if (selectedBlueAlliance.isTrue) {
                        var blueList = sv.blueAllianceMatches;
                        team1.value = blueList[value][0].toString();
                        team2.value = blueList[value][1].toString();
                        team3.value = blueList[value][2].toString();
                      } else {
                        var redList = sv.redAllianceMatches;
                        team1.value = redList[value][0].toString();
                        team2.value = redList[value][1].toString();
                        team3.value = redList[value][2].toString();
                      }
                    },
                    items: matches
                        .map((dynamic matchNum) => DropdownMenuItem<dynamic>(
                              value: matchNum,
                              child: Text(
                                'Match $matchNum',
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
                    iconStyleData: const IconStyleData(
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.white),
                    dropdownStyleData: DropdownStyleData(
                      scrollbarTheme: const ScrollbarThemeData(
                          thumbColor: MaterialStatePropertyAll(Colors.grey)),
                      maxHeight: 400.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r)),
                    ),
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(15.r)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: const Center(
              child: Text(
                'Select a Team',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'NotoSans', fontSize: 30),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              teamInMatch(text: team1, teamNumber: localTeam),
              teamInMatch(text: team2, teamNumber: localTeam),
              teamInMatch(text: team3, teamNumber: localTeam),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Obx(
                  () => Text(
                    'Alliance: $localAlliacne',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Obx(
                  () => Text(
                    'Match: $localMatch',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: Center(
              child: Obx(
                () => Text(
                  'Team: $localTeam',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontFamily: 'NotoSans',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Obx(
              () => Text(
                'Team Name: ${sv.teamName}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'NotoSans',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (localTeam.isNotEmpty) {
                    matchHint.value = 'Select a Match';
                    matches.value = [];
                    team1.value = '';
                    team2.value = '';
                    team3.value = '';

                    localAlliacne.value = '';
                    localMatch.value = '';
                    localTeam.value = '';
                    sv.teamName.value = '';

                    Get.to(() => const AutoStart());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        showCloseIcon: true,
                        backgroundColor: Colors.grey[800],
                        content: const Text(
                          'No Team Selected',
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 13.h),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadiusDirectional.circular(25.r)),
                    width: 180.w,
                    height: 45.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Auto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NotoSans',
                              fontSize: 28),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 28,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: rw.bnb(),
    );
  }
}
