import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/read_sheet.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/auto_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ManualPage extends StatelessWidget {
  const ManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    SheetValues sv = Get.put(SheetValues());
    ReuseWid rw = Get.put(ReuseWid());

    final teamNumber = TextEditingController();
    final matchNumber = TextEditingController();

    return Scaffold(
      appBar: rw.ab(title: 'Manual Version'),
      body: Center(
        child: Column(
          children: [
            rw.line(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 120.w,
                    child: TextField(
                      autocorrect: false,
                      controller: teamNumber,
                      textAlign: TextAlign.center,
                      enabled: true,
                      cursorColor: ut.tt.value,
                      style: TextStyle(
                          color: ut.tt.value,
                          fontFamily: 'NotoSans',
                          fontSize: 20),
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
                        labelStyle: TextStyle(color: ut.tt.value),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: ut.tt.value)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide:
                                BorderSide(color: ut.tt.value, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide:
                                BorderSide(color: ut.tt.value, width: 2)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 120.w,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      controller: matchNumber,
                      textAlign: TextAlign.center,
                      enabled: true,
                      cursorColor: ut.tt.value,
                      style: TextStyle(
                          color: ut.tt.value,
                          fontFamily: 'NotoSans',
                          fontSize: 20),
                      decoration: InputDecoration(
                        label: Center(
                          child: Text(
                            'Match #',
                            style: TextStyle(
                                color: ut.ts.value,
                                fontFamily: 'NotoSans',
                                fontSize: 20),
                          ),
                        ),
                        labelStyle: TextStyle(color: ut.tt.value),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: ut.tt.value)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide:
                                BorderSide(color: ut.tt.value, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide:
                                BorderSide(color: ut.tt.value, width: 2)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: GestureDetector(
                onTap: () async {
                  if (teamNumber.text.isEmpty || matchNumber.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.red,
                        child: SizedBox(
                          width: 150.w,
                          height: 150.h,
                          child: const Center(
                            child: Text(
                              'ENTER THE VALUES',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SenorSaturno',
                                  fontSize: 40),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    Map<int, String> teamNumAndName = await eventTeams();
                    sv.eventTeams.value = teamNumAndName;
                    sv.teamNum.value = int.parse(teamNumber.text);
                    sv.matchNum.value = int.parse(matchNumber.text);
                    sv.teamName.value = sv.eventTeams[sv.teamNum.value];
                    Get.off(() => const AutoStart());
                  }
                },
                child: Container(
                  width: 200.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(35.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Auto',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NotoSans',
                            fontSize: 25),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
