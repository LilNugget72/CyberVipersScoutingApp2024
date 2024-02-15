import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/endgame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TeleopScreen extends StatelessWidget {
  const TeleopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();
    SheetValues sv = Get.find();
    return Scaffold(
      appBar: rw.ab(title: 'Teleop Period'),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sv.valueCard(value: sv.teleopAmp, title: 'Amp'),
                  sv.valueCard(value: sv.trap, title: 'Missed')
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sv.valueCard(value: sv.teleopSpeaker, title: 'Speaker'),
                  sv.valueCard(value: sv.trap, title: 'Missed')
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sv.valueCard(value: sv.trap, title: 'Trap'),
                  sv.valueCard(value: sv.trap, title: 'Missed')
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(() => const Endgame()),
              child: Container(
                width: 250.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: ut.buttonColor.value,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: const Center(
                    child: Text(
                  'To "Endgame"',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSans',
                      fontSize: 24),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
