import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cyberviperscoutingapp2024/read_sheet.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();
    UserTheme ut = Get.find();
    SheetValues sv = Get.find();

    List testList = [];
    List thing = sv.teamXList;
    testList = thing;
    return Scaffold(
      appBar: rw.ab(title: 'Stats Page'),
      drawer: rw.d(),
      body: ListView(
        //  items: sv.teamXList
        //           .map((dynamic teamNumber) => DropdownMenuItem<String>(
        //                 value: teamNumber.toString(),
        //                 child: Text(
        //                   teamNumber.toString(),
        //                   style: TextStyle(
        //                       color: Colors.black,
        //                       fontFamily: 'NotoSans',
        //                       fontSize: 15,
        //                       fontWeight: FontWeight.bold,
        //                       letterSpacing: 1),
        //                 ),
        //               ))
        //           .toList(),
        children: [
          Obx(
            () => DropdownButton2(
              isExpanded: true,
              hint: Obx(
                () => Text(
                  sv.teamListHint.value,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NotoSans',
                    fontSize: 15,
                  ),
                ),
              ),
              onChanged: (value) {
                sv.matchNum.value = value!;
                sv.teamListHint.value = value.toString();
              },
              items: sv.teamXList
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
              // dropdownStyleData: DropdownStyleData(
              //   maxHeight: 200.h,
              //   width: 200.w,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(14),
              //     color: Colors.redAccent,
              //   ),
              //   offset: const Offset(-20, 0),
              //   scrollbarTheme: ScrollbarThemeData(
              //     radius: const Radius.circular(40),
              //     thickness: MaterialStateProperty.all(6),
              //     thumbVisibility: MaterialStateProperty.all(true),
              //   ),
              // ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                color: Colors.red,
              ),
              Container(
                width: 50.w,
                height: 50.w,
                color: Colors.blue,
              ),
              Container(
                width: 50.w,
                height: 50.w,
                color: Colors.pink,
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: rw.bnb(),
    );
  }
}
/*
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
