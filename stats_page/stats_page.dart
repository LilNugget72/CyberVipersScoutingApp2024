import 'package:cyberviperscoutingapp2024/controllers/field_with_buttons.dart';
import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/stats_page/stats_fields.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cyberviperscoutingapp2024/stats_page/read_sheet.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

showAverage({required RxString value}) {
  return Container(
    width: 70.w,
    height: 60.h,
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
            fontSize: 15,
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

    RxString firstAverage = ''.obs;
    RxString secondAverage = ''.obs;
    RxString thirdAverage = ''.obs;

    RxString firstATitle = 'Amp'.obs;
    RxString secondATitle = 'Speaker'.obs;
    RxString thirdATitle = 'Trap'.obs;

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
                  var matchValues =
                      await getDataForMatchNumber(team: value.toString());
                  if (matchValues.isNotEmpty) {
                    var first = getAllAverageNumbers(made: 16, missed: 17);
                    var second = getAllAverageNumbers(made: 18, missed: 19);
                    var third = getAllAverageNumbers(made: 20, missed: 21);

                    firstAverage.value = first.toString();
                    secondAverage.value = second.toString();
                    thirdAverage.value = third.toString();
                    sv.selectMatch.value = 'Select a Match';
                  } else {
                    firstAverage.value = 'No Data';
                    secondAverage.value = 'No Data';
                    thirdAverage.value = 'No Data';
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
          Center(
            child: Obx(
              () => SizedBox(
                width: 150.w,
                child: DropdownButton2(
                  underline: const SizedBox(),
                  isExpanded: true,
                  hint: Obx(
                    () => Text(
                      ' ${sv.selectMatch}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSans',
                        fontSize: 15,
                      ),
                    ),
                  ),
                  onChanged: (value) async {
                    bool startedInAuto = false;
                    sv.selectMatch.value = 'Match $value';
                    sf.clearView();

                    if (sv.matchNumAndValue.isNotEmpty) {
                      double first = getMatchAverageNumbers(
                          made: 16, missed: 17, match: value);
                      double second = getMatchAverageNumbers(
                          made: 18, missed: 19, match: value);
                      double third = getMatchAverageNumbers(
                          made: 20, missed: 21, match: value);

                      for (int i = 1; i <= 4; i++) {
                        String position = getMatchBool(column: i, match: value);

                        switch (i) {
                          case 1:
                            if (position != 'FALSE') {
                              sf.viewZone1.value = ut.buttonColor.value;
                              startedInAuto = true;
                              break;
                            }
                          case 2:
                            if (position != 'FALSE') {
                              sf.viewZone2.value = ut.buttonColor.value;
                              startedInAuto = true;
                              break;
                            }
                          case 3:
                            if (position != 'FALSE') {
                              sf.viewZone3.value = ut.buttonColor.value;
                              startedInAuto = true;
                              break;
                            }
                          case 4:
                            if (position != 'FALSE') {
                              sf.viewZone4.value = ut.buttonColor.value;
                              startedInAuto = true;
                              break;
                            }
                        }
                      }

                      firstAverage.value = first.toString();
                      secondAverage.value = second.toString();
                      thirdAverage.value = third.toString();
                      if (startedInAuto == true) {
                        for (int i = 5; i <= 12; i++) {
                          String whenSelected =
                              getMatchBool(column: i, match: value);

                          switch (i) {
                            case 5:
                              if (whenSelected != '0') {
                                sf.viewNote1.value = whenSelected;
                                break;
                              }
                            case 6:
                              if (whenSelected != '0') {
                                sf.viewNote2.value = whenSelected;
                                break;
                              }
                            case 7:
                              if (whenSelected != '0') {
                                sf.viewNote3.value = whenSelected;
                                break;
                              }
                            case 8:
                              if (whenSelected != '0') {
                                sf.viewNote4.value = whenSelected;
                                break;
                              }
                            case 9:
                              if (whenSelected != '0') {
                                sf.viewNote5.value = whenSelected;
                                break;
                              }

                            case 10:
                              if (whenSelected != '0') {
                                sf.viewNote6.value = whenSelected;
                                break;
                              }
                            case 11:
                              if (whenSelected != '0') {
                                sf.viewNote7.value = whenSelected;
                                break;
                              }
                            case 12:
                              if (whenSelected != '0') {
                                sf.viewNote8.value = whenSelected;
                                break;
                              }
                          }
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
          SizedBox(
            height: 10.h,
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
              showAverage(value: firstAverage),
              showAverage(value: secondAverage),
              showAverage(value: thirdAverage)
            ],
          ),
          sf.statsBlueAuto()
        ],
      ),
      bottomNavigationBar: rw.bnb(),
    );
  }
}
/*
 onChanged: (value) async {
                sv.selectedTeamNumber.value = value!;
                sv.teamListHint.value = value.toString();

                var test = await getAllValuesFromAMatch();
                sv.selectedTeamValue.value = test;
                ampAverage.value = '${test[33]}';
              },
sv.teamXList
                  .map((dynamic teamNumber) => DropdownMenuItem<int>(
                        value: teamNumber,
                        child: Text(
                          teamNumber.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'NotoSans',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                      ))
                  .toList(),

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
