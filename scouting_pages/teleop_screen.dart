import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/endgame.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/engame_defense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TeleopScreen extends StatelessWidget {
  const TeleopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();
    SheetValues sv = Get.find();
    UserTheme ut = Get.find();
    EndgameDefense ed = Get.put(EndgameDefense());
    return Scaffold(
      appBar: rw.ab(title: 'Teleop'),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            rw.line(),
            rw.teaminfo(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sv.valueCard(value: sv.teleopAmp, title: 'Amp'),
                  sv.valueCard(value: sv.ampMissed, title: 'Missed')
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sv.valueCard(value: sv.teleopSpeaker, title: 'Speaker'),
                  sv.valueCard(value: sv.speakerMissed, title: 'Missed')
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sv.valueCard(value: sv.trap, title: 'Trap'),
                  sv.valueCard(value: sv.trapMissed, title: 'Missed')
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const Endgame());
                ed.dNoneColor.value = ut.buttonColor.value;
              },
              child: Container(
                width: 250.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: ut.buttonColor.value,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '"Endgame"',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSans',
                          fontSize: 25),
                    ),
                    SizedBox(
                      width: 7.w,
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
          ],
        ),
      ),
    );
  }
}
