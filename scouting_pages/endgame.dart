import 'package:cyberviperscoutingapp2024/controllers/field_with_buttons.dart';
import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/engame_defense.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/final_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Endgame extends StatefulWidget {
  const Endgame({super.key});

  @override
  State<Endgame> createState() => _EndgameState();
}

class _EndgameState extends State<Endgame> {
  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();
    SheetValues sv = Get.find();
    TouchField tf = Get.find();
    UserTheme ut = Get.find();
    EndgameDefense ed = Get.put(EndgameDefense());

    Rx<Color> parkedColor = Colors.transparent.obs;
    Color parkedTextColor = ut.tt.value;
    Rx<Color> harmonyColor = Colors.transparent.obs;
    Color harmonyTextColor = ut.tt.value;

    return Scaffold(
      appBar: rw.ab(title: '"Endgame"'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
            child: rw.teaminfo(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                rw.valueToggle(
                    value: sv.park,
                    title: 'Parked',
                    width: 120.w,
                    height: 60.h,
                    fillColor: parkedColor,
                    textColor: parkedTextColor),
                SizedBox(
                  width: 25.w,
                ),
                rw.valueToggle(
                    value: sv.harmony,
                    title: 'Harmony',
                    width: 135.w,
                    height: 60.h,
                    fillColor: harmonyColor,
                    textColor: harmonyTextColor),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Text(
              'Defense',
              style: TextStyle(
                  color: ut.tt.value, fontFamily: 'NotoSans', fontSize: 35),
            ),
          ),
          ed.defenseRow(),
          Padding(
            padding: EdgeInsets.only(top: 40.h, bottom: 25.h),
            child: tf.blueStage(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: GestureDetector(
                onTap: () => Get.to(() => const FinalPage()),
                child: Container(
                  width: 250.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: ut.buttonColor.value,
                    borderRadius: BorderRadius.circular(35.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Comments',
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
            ),
          ),
        ],
      ),
    );
  }
}
