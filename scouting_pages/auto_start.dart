import 'package:cyberviperscoutingapp2024/controllers/field_with_buttons.dart';
import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/teleop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoStart extends StatelessWidget {
  const AutoStart({super.key});

  @override
  Widget build(BuildContext context) {
    UserTheme ut = Get.find();
    ReuseWid rw = Get.find();
    SheetValues sv = Get.find();
    TouchField tf = Get.put(TouchField());

    Rx<Color> leaveColor = Colors.transparent.obs;
    return Scaffold(
      appBar: rw.ab(title: 'Auto'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          rw.line(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: rw.teaminfo(),
          ),
          sv.alliance.value == 'Blue' ? tf.blueSide() : tf.redSide(),
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    rw.valueToggle(
                      title: 'Leave',
                      value: sv.leave,
                      width: 160.w,
                      height: 75.h,
                      fillColor: leaveColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: sv.valueCard(value: sv.autoAmp, title: 'Amp'),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const TeleopScreen());
                      },
                      child: Container(
                          width: 160.w,
                          height: 75.h,
                          decoration: BoxDecoration(
                              color: ut.buttonColor.value,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Teleop',
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
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child:
                          sv.valueCard(value: sv.autoSpeaker, title: 'Speaker'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

p() {}
