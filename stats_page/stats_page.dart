import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
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
    return Scaffold(
      appBar: rw.ab(title: 'Stats Page'),
      drawer: rw.d(),
      body: Center(
          child: Row(
        children: [],
      )),
      bottomNavigationBar: rw.bnb(),
    );
  }
}
//   Center(
//         child: LineChart(
//           LineChartData(
//             lineTouchData: const LineTouchData(enabled: false),
//             lineBarsData: [
//               LineChartBarData(
//                 dashArray: <int>[5, 5],
//                 barWidth: 4,
//                 curveSmoothness: 0.3,
//                 isCurved: true,
//                 spots: const [
//                   FlSpot(1, 10),
//                   FlSpot(2, 4),
//                   FlSpot(3, 7),
//                   FlSpot(4, 8),
//                   FlSpot(5, 8),
//                 ],
//               ),
//             ],
//             borderData:
//                 FlBorderData(border: Border.all(color: ut.tt.value, width: 3)),
//             minX: 1,
//             maxX: 12,
//             minY: 0,
//             maxY: 20,
//             titlesData: FlTitlesData(
//               rightTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 40.h,
//                 ),
//               ),
//               topTitles: const AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//               bottomTitles: AxisTitles(
//                 axisNameSize: 40.h,
//                 axisNameWidget: rw.textForGraph(name: 'Match'),
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 25.h,
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 axisNameWidget: rw.textForGraph(name: 'Speaker'),
//                 axisNameSize: 35.w,
//                 sideTitles: SideTitles(showTitles: true, reservedSize: 24.h),
//               ),
//             ),
//           ),
//         ),
//       ),
// }
