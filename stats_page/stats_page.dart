import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/stats_page/stats_fields.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cyberviperscoutingapp2024/stats_page/read_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//TODO finish implementing the chart in the app
// TODO add more averages

showAverage({required RxString value}) {
  return Container(
    width: 70.w,
    height: 55.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white, width: 2)),
    child: Obx(
      () => Center(
        child: Text(
          value.value,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'NotoSans',
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}

titles({required RxString title}) {
  return Text(
    title.value,
    style: const TextStyle(
      color: Colors.white,
      fontFamily: 'NotoSans',
      fontSize: 20,
    ),
  );
}

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.put(ReuseWid());
    UserTheme ut = Get.find();
    SheetValues sv = Get.find();
    StatsFields sf = Get.put(StatsFields());

    RxString firstATitle = 'Amp'.obs;
    RxString secondATitle = 'Speaker'.obs;
    RxString thirdATitle = 'Trap'.obs;

    RxString autoTitleAmp = 'Amp'.obs;
    RxString autoTitleSpeaker = 'Speaker'.obs;

    return Scaffold(
      appBar: rw.ab(title: 'Stats Page'),
      drawer: rw.d(),
      body: ListView(
        children: [
          Center(
            child: Obx(
              () => DropdownButton2(
                underline: const SizedBox(),
                isExpanded: true,
                hint: Obx(
                  () => Text(
                    '      ${sv.teamListHint}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSans',
                      fontSize: 15,
                    ),
                  ),
                ),
                onChanged: (value) async {
                  sv.selectedTeamNumber.value = value!;
                  sv.teamListHint.value = '$value - ${sv.eventTeams[value]}';
                  sf.clearView();
                  var matchValues =
                      await getDataForMatchNumber(team: value.toString());

                  if (matchValues.isNotEmpty) {
                    var first = getAllAverageNumbers(made: 17);
                    var second = getAllAverageNumbers(made: 19);
                    var third = getAllAverageNumbers(made: 21);

                    var autoAmpAv = getAllAverageNumbers(made: 15);
                    var autoSpeakAv = getAllAverageNumbers(made: 16);

                    var parkav = getBoolAverage(value: 31);
                    var harmonyav = getBoolAverage(value: 32);
                    int defav = seeAverageDefense();

                    switch (defav) {
                      case 1:
                        sf.none.value = ut.buttonColor.value;
                        break;
                      case 2:
                        sf.slight.value = ut.buttonColor.value;
                        break;
                      case 3:
                        sf.modest.value = ut.buttonColor.value;
                        break;
                      case 4:
                        sf.generous.value = ut.buttonColor.value;
                        break;
                      case 5:
                        sf.exclusively.value = ut.buttonColor.value;
                        break;
                    }

                    sf.stats1.value = first.toString();
                    sf.stats2.value = second.toString();
                    sf.stats3.value = third.toString();
                    sf.autoAmp.value = autoAmpAv.toString();
                    sf.autoSpeak.value = autoSpeakAv.toString();
                    sf.parked.value = parkav;
                    sf.harmony.value = harmonyav;
                    sv.selectMatch.value = 'Select a Match';
                  } else {
                    sv.matchAndRowNum.value = [];
                    sv.selectMatch.value = 'N/A';
                    sf.stats1.value = 'N/A';
                    sf.stats2.value = 'N/A';
                    sf.stats3.value = 'N/A';
                    sf.autoAmp.value = 'N/A';
                    sf.autoSpeak.value = 'N/A';
                    sf.parked.value = 'N/A';
                    sf.harmony.value = 'N/A';
                  }
                },
                items: sv.teamXList
                    .map((dynamic teamNumber) => DropdownMenuItem<int>(
                          value: teamNumber,
                          child: Text(
                            '${teamNumber.toString()} - ${sv.eventTeams[teamNumber]}',
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
                      borderRadius: BorderRadius.circular(15.r)),
                ),
                buttonStyleData: ButtonStyleData(
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Center(
              child: Obx(
                () => SizedBox(
                  width: 160.w,
                  child: DropdownButton2(
                    underline: const SizedBox(),
                    isExpanded: true,
                    hint: Obx(
                      () => Text(
                        '${sv.selectMatch}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSans',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    onChanged: (value) async {
                      sv.alreadyInStats.value = true;
                      bool startedInAuto = false;
                      sv.selectMatch.value = 'Match $value';
                      sf.clearView();
                      var startsBlue = sv.matchNumAndValue[value][0];
                      startsBlue == 'Blue'
                          ? sv.statsWantsBlue.value = true
                          : sv.statsWantsBlue.value = false;
                      startsBlue == 'Blue'
                          ? ut.buttonColor.value =
                              const Color.fromARGB(255, 0, 101, 179)
                          : ut.buttonColor.value =
                              const Color.fromARGB(255, 237, 52, 52);

                      if (sv.matchNumAndValue.isNotEmpty) {
                        String first = getMatchAverageNumbers(
                            made: 17, missed: 18, match: value);
                        String second = getMatchAverageNumbers(
                            made: 19, missed: 20, match: value);
                        String third = getMatchAverageNumbers(
                            made: 21, missed: 22, match: value);

                        for (int i = 2; i <= 5; i++) {
                          String position =
                              getMatchBool(column: i, match: value);

                          switch (i) {
                            case 2:
                              if (position != 'FALSE') {
                                sf.viewZone1.value = ut.buttonColor.value;
                                startedInAuto = true;
                                break;
                              }
                            case 3:
                              if (position != 'FALSE') {
                                sf.viewZone2.value = ut.buttonColor.value;
                                startedInAuto = true;
                                break;
                              }
                            case 4:
                              if (position != 'FALSE') {
                                sf.viewZone3.value = ut.buttonColor.value;
                                startedInAuto = true;
                                break;
                              }
                            case 5:
                              if (position != 'FALSE') {
                                sf.viewZone4.value = ut.buttonColor.value;
                                startedInAuto = true;
                                break;
                              }
                          }
                        }

                        sf.stats1.value = first.toString();
                        sf.stats2.value = second.toString();
                        sf.stats3.value = third.toString();
                        if (startedInAuto == true) {
                          for (int i = 6; i <= 13; i++) {
                            String whenSelected =
                                getMatchBool(column: i, match: value);

                            switch (i) {
                              case 6:
                                if (whenSelected != '0') {
                                  sf.viewNote1.value = whenSelected;
                                  sf.note1Color.value = ut.buttonColor.value;
                                  break;
                                }
                              case 7:
                                if (whenSelected != '0') {
                                  sf.viewNote2.value = whenSelected;
                                  sf.note2Color.value = ut.buttonColor.value;
                                  break;
                                }
                              case 8:
                                if (whenSelected != '0') {
                                  sf.viewNote3.value = whenSelected;
                                  sf.note3Color.value = ut.buttonColor.value;
                                  break;
                                }
                              case 9:
                                if (whenSelected != '0') {
                                  sf.viewNote4.value = whenSelected;
                                  sf.note4Color.value = ut.buttonColor.value;
                                  break;
                                }
                              case 10:
                                if (whenSelected != '0') {
                                  sf.viewNote5.value = whenSelected;
                                  sf.note5Color.value = ut.buttonColor.value;
                                  break;
                                }

                              case 11:
                                if (whenSelected != '0') {
                                  sf.viewNote6.value = whenSelected;
                                  sf.note6Color.value = ut.buttonColor.value;
                                  break;
                                }
                              case 12:
                                if (whenSelected != '0') {
                                  sf.viewNote7.value = whenSelected;
                                  sf.note7Color.value = ut.buttonColor.value;
                                  break;
                                }
                              case 13:
                                if (whenSelected != '0') {
                                  sf.viewNote8.value = whenSelected;
                                  sf.note8Color.value = ut.buttonColor.value;
                                  break;
                                }
                            }
                          }
                        }

                        for (int i = 23; i <= 25; i++) {
                          String stagePos =
                              getMatchBool(column: i, match: value);
                          switch (i) {
                            case 23:
                              if (stagePos == 'TRUE') {
                                sf.stage1.value = ut.buttonColor.value;
                                break;
                              }
                            case 24:
                              if (stagePos == 'TRUE') {
                                sf.stage2.value = ut.buttonColor.value;
                                break;
                              }
                            case 25:
                              if (stagePos == 'TRUE') {
                                sf.stage3.value = ut.buttonColor.value;
                                break;
                              }
                          }
                        }
                        for (int i = 31; i <= 34; i++) {
                          String others = sv.matchNumAndValue[value][i];
                          switch (i) {
                            case 31:
                              others == 'FALSE'
                                  ? sf.parked.value = 'No'
                                  : sf.parked.value = "Yes";
                            case 32:
                              others == 'FALSE'
                                  ? sf.harmony.value = 'No'
                                  : sf.harmony.value = "Yes";
                            case 33:
                              others == 'empty'
                                  ? sf.comments.value = 'No comments available'
                                  : sf.comments.value = others;
                            case 34:
                              others == 'empty'
                                  ? sf.scouter.value = 'No Scouter?'
                                  : sf.scouter.value = others;
                          }
                        }
                        for (int i = 26; i <= 30; i++) {
                          String defense = sv.matchNumAndValue[value][i];
                          switch (i) {
                            case 26:
                              defense == 'TRUE'
                                  ? sf.none.value = ut.buttonColor.value
                                  : sf.none.value = Colors.transparent;
                            case 27:
                              defense == 'TRUE'
                                  ? sf.slight.value = ut.buttonColor.value
                                  : sf.slight.value = Colors.transparent;
                            case 28:
                              defense == 'TRUE'
                                  ? sf.modest.value = ut.buttonColor.value
                                  : sf.modest.value = Colors.transparent;
                            case 29:
                              defense == 'TRUE'
                                  ? sf.generous.value = ut.buttonColor.value
                                  : sf.generous.value = Colors.transparent;
                            case 30:
                              defense == 'TRUE'
                                  ? sf.exclusively.value = ut.buttonColor.value
                                  : sf.exclusively.value = Colors.transparent;
                          }
                        }
                        for (int i = 15; i <= 16; i++) {
                          String autoValues = sv.matchNumAndValue[value][i];
                          switch (i) {
                            case 15:
                              sf.autoAmp.value = autoValues;
                            case 16:
                              sf.autoSpeak.value = autoValues;
                          }
                        }
                      }
                    },
                    items: sv.matchAndRowNum
                        .map((dynamic matchNum) => DropdownMenuItem<dynamic>(
                              value: matchNum,
                              child: Text(
                                'Match ${matchNum.toString()}',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              titles(title: firstATitle),
              titles(title: secondATitle),
              titles(title: thirdATitle)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              showAverage(value: sf.stats1),
              showAverage(value: sf.stats2),
              showAverage(value: sf.stats3)
            ],
          ),
          // SizedBox(
          //   width: 200.w,
          //   height: 400.h,
          //   child: LineChart(
          //     LineChartData(
          //       titlesData: const FlTitlesData(
          //         leftTitles: AxisTitles(axisNameWidget: Text('Notes')),

          //       ),
          //       lineBarsData: [LineChartBarData()],
          //       gridData: const FlGridData(
          //           horizontalInterval: 1, verticalInterval: 1),
          //       lineTouchData: const LineTouchData(enabled: false),
          //       backgroundColor: Colors.green,
          //       borderData: FlBorderData(
          //           show: true, border: Border.all(color: Colors.white)),
          //       maxX: 12,
          //       maxY: 20,
          //       minX: 0,
          //       minY: 0,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 20.h,
          ),
          rw.line(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: const Center(
              child: Text(
                'Auto Path',
                style: TextStyle(
                    fontFamily: 'NotoSans', fontSize: 25, color: Colors.white),
              ),
            ),
          ),
          Obx(
            () => sv.statsWantsBlue.value
                ? sf.statsBlueAuto()
                : sf.statsRedAuto(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    titles(title: autoTitleAmp),
                    showAverage(value: sf.autoAmp)
                  ],
                ),
                Column(
                  children: [
                    titles(title: autoTitleSpeaker),
                    showAverage(value: sf.autoSpeak)
                  ],
                ),
              ],
            ),
          ),
          rw.line(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: const Center(
              child: Text(
                'Endgame',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'NotoSans', fontSize: 25),
              ),
            ),
          ),
          Obx(
            () => sv.statsWantsBlue.value
                ? sf.statsBlueStage()
                : sf.statsRedStage(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: const Center(
                child: Text(
              "Defense",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 25, fontFamily: 'NotoSans'),
            )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: sf.defenseRow(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            color: ut.buttonColor.value,
                            borderRadius:
                                BorderRadiusDirectional.circular(15.r)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          child: Column(
                            children: [
                              const Text(
                                "Parked",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'NotoSans',
                                    fontSize: 27),
                              ),
                              Text(
                                sf.parked.value,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'NotoSans',
                                    fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            color: ut.buttonColor.value,
                            borderRadius:
                                BorderRadiusDirectional.circular(15.r)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          child: Column(
                            children: [
                              const Text(
                                "Harmony",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'NotoSans',
                                    fontSize: 27),
                              ),
                              Text(
                                sf.harmony.value,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'NotoSans',
                                    fontSize: 25),
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
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: const Center(
              child: Text(
                "Comments:",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'NotoSans', fontSize: 25),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Center(
              child: Obx(
                () => Text(
                  sf.comments.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSans',
                      fontSize: 20),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Center(
              child: Obx(
                () => Text(
                  'Scouter: ${sf.scouter}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSans',
                      fontSize: 25),
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
/*
SizedBox(
            width: 200.w,
            height: 450.h,
            child: LineChart(
              LineChartData(
                backgroundColor: Colors.white,
                lineTouchData: const LineTouchData(enabled: false),
                lineBarsData: [
                  LineChartBarData(
                    dashArray: <int>[5, 5],
                    barWidth: 4,
                    curveSmoothness: 0.3,
                    isCurved: true,
                    spots: const [
                      FlSpot(1, 10),
                      FlSpot(2, 4),
                      FlSpot(3, 7),
                      FlSpot(4, 8),
                      FlSpot(5, 8),
                    ],
                  ),
                ],
                borderData: FlBorderData(
                    border: Border.all(color: ut.tt.value, width: 3)),
                minX: 1,
                maxX: 10,
                minY: 0,
                maxY: 10,
                titlesData: FlTitlesData(
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40.h,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    axisNameSize: 40.h,
                    axisNameWidget: rw.textForGraph(name: 'Match'),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 25.h,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: rw.textForGraph(name: 'Speaker'),
                    axisNameSize: 35.w,
                    sideTitles:
                        SideTitles(showTitles: true, reservedSize: 24.h),
                  ),
                ),
              ),
            ),
          ),
      */
