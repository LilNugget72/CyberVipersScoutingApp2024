import 'package:cyberviperscoutingapp2024/controllers/field_with_buttons.dart';
import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Endgame extends StatelessWidget {
  const Endgame({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();
    SheetValues sv = Get.find();
    TouchField tf = Get.find();
    UserTheme ut = Get.find();
    return Scaffold(
      appBar: rw.ab(title: '"Endgame"'),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              rw.valueToggle(
                value: sv.park,
                title: 'Parked',
                width: 120.w,
                height: 55.h,
              ),
              SizedBox(
                width: 25.w,
              ),
              rw.valueToggle(
                value: sv.harmony,
                title: 'Harmony',
                width: 120.w,
                height: 55.h,
              ),
            ],
          ),
          tf.redStage(),
          TextField(
            controller: sv.comments,
            textAlign: TextAlign.center,
            enabled: true,
            cursorColor: ut.tt.value,
            style: TextStyle(
                color: ut.tt.value, fontFamily: 'NotoSans', fontSize: 20),
            decoration: InputDecoration(
              labelText: 'Comments',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(color: ut.tt.value),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: ut.tt.value)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ut.tt.value)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ut.tt.value)),
            ),
          ),
        ],
      ),
    );
  }
}
