import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cyberviperscoutingapp2024/read_sheet.dart';
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
    ReuseWid rw = Get.find();
    UserTheme ut = Get.find();
    SheetValues sv = Get.find();

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
          Obx(
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
                sv.teamListHint.value = value.toString();
                sv.teamListHint.value = '$value - ${sv.eventTeams[value]}';
                await getAllValuesFromAMatch();
                var first = await getMatchAverage(made: 16, missed: 17);
                var second = await getMatchAverage(made: 18, missed: 19);
                var third = await getMatchAverage(made: 20, missed: 21);
                await matchAndRowNum();

                firstAverage.value = first.toString();
                secondAverage.value = second.toString();
                thirdAverage.value = third.toString();
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
                decoration: const BoxDecoration(color: Colors.white),
              ),
              buttonStyleData: ButtonStyleData(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
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
                  onChanged: (value) async {},
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
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                    ),
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

Center(
        child: Center(
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
                  sideTitles: SideTitles(showTitles: true, reservedSize: 24.h),
                ),
              ),
            ),
          ),
        ),
      ),
      */
