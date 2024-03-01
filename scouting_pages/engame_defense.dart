import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

UserTheme ut = Get.put(UserTheme());
SheetValues sv = Get.put(SheetValues());

class EndgameDefense extends GetxController {
  Rx<Color> dNoneColor = Colors.transparent.obs;
  Rx<Color> dSlightColor = Colors.transparent.obs;
  Rx<Color> dModestColor = Colors.transparent.obs;
  Rx<Color> dGenerousColor = Colors.transparent.obs;
  Rx<Color> dExclusivelyColor = Colors.transparent.obs;

  toggleDefense(
      {required RxBool defense,
      required String title,
      required double width,
      required Rx<Color> fillColor}) {
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(10.r),
      onTap: () {
        dNoneColor.value = Colors.transparent;
        dSlightColor.value = Colors.transparent;
        dModestColor.value = Colors.transparent;
        dGenerousColor.value = Colors.transparent;
        dExclusivelyColor.value = Colors.transparent;

        fillColor.value = ut.buttonColor.value;

        sv.dNone.value = false;
        sv.dSlight.value = false;
        sv.dModest.value = false;
        sv.dGenerous.value = false;
        sv.dExclusively.value = false;

        defense.value = true;
      },
      child: Obx(
        () => Ink(
          width: width,
          height: 35.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: ut.buttonColor.value, width: 2.w),
              color: fillColor.value),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontSize: 15, fontFamily: 'NotoSans'),
            ),
          ),
        ),
      ),
    );
  }

  defenseRow() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          toggleDefense(
            defense: sv.dNone,
            title: 'None',
            width: 50.w,
            fillColor: dNoneColor,
          ),
          toggleDefense(
            defense: sv.dSlight,
            title: 'Slight',
            width: 55.w,
            fillColor: dSlightColor,
          ),
          toggleDefense(
            defense: sv.dModest,
            title: 'Modest',
            width: 63.w,
            fillColor: dModestColor,
          ),
          toggleDefense(
            defense: sv.dGenerous,
            title: 'Generous',
            width: 70.w,
            fillColor: dGenerousColor,
          ),
          toggleDefense(
            defense: sv.dExclusively,
            title: 'Exclusively',
            width: 81.w,
            fillColor: dExclusivelyColor,
          )
        ],
      ),
    );
  }

  finished() {
    dNoneColor.value = ut.buttonColor.value;
    dSlightColor.value = Colors.transparent;
    dModestColor.value = Colors.transparent;
    dGenerousColor.value = Colors.transparent;
    dExclusivelyColor.value = Colors.transparent;
  }
}
