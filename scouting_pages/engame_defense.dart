import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

UserTheme ut = Get.put(UserTheme());
SheetValues sv = Get.put(SheetValues());

class EndgameDefense extends GetxController {
  Rx<Color> dNoneColor = Colors.transparent.obs;
  Color dNoneTextColor = ut.tt.value;
  Rx<Color> dSlightColor = Colors.transparent.obs;
  Color dSlightTextColor = ut.tt.value;
  Rx<Color> dModerateColor = Colors.transparent.obs;
  Color dModerateTextColor = ut.tt.value;
  Rx<Color> dGoodAmountColor = Colors.transparent.obs;
  Color dGoodAmountTextColor = ut.tt.value;
  Rx<Color> dAllTheyDoColor = Colors.transparent.obs;
  Color dAllTheyDoTextColor = ut.tt.value;

  toggleDefense(
      {required RxBool defense,
      required String title,
      required double width,
      required Rx<Color> fillColor,
      required Color textColor}) {
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(10.r),
      onTap: () {
        dNoneColor.value = Colors.transparent;
        dSlightColor.value = Colors.transparent;
        dModerateColor.value = Colors.transparent;
        dGoodAmountColor.value = Colors.transparent;
        dAllTheyDoColor.value = Colors.transparent;

        fillColor.value = ut.buttonColor.value;
        textColor = ut.tt.value;

        sv.dNone.value = false;
        sv.dModest.value = false;
        sv.dGenerous.value = false;
        sv.dPlenty.value = false;
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
              style: TextStyle(
                  color: textColor, fontSize: 15, fontFamily: 'NotoSans'),
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
              textColor: dNoneTextColor),
          toggleDefense(
              defense: sv.dModest,
              title: 'Modest',
              width: 55.w,
              fillColor: dSlightColor,
              textColor: dSlightTextColor),
          toggleDefense(
              defense: sv.dGenerous,
              title: 'Generous',
              width: 75.w,
              fillColor: dModerateColor,
              textColor: dModerateTextColor),
          toggleDefense(
              defense: sv.dPlenty,
              title: 'Plenty',
              width: 50.w,
              fillColor: dGoodAmountColor,
              textColor: dGoodAmountTextColor),
          toggleDefense(
              defense: sv.dExclusively,
              title: 'Exclusively',
              width: 81.w,
              fillColor: dAllTheyDoColor,
              textColor: dAllTheyDoTextColor)
        ],
      ),
    );
  }

  finished() {
    dNoneColor.value = ut.buttonColor.value;
    dNoneTextColor = ut.tt.value;
    dSlightColor.value = Colors.transparent;
    dSlightTextColor = ut.tt.value;
    dModerateColor.value = Colors.transparent;
    dModerateTextColor = ut.tt.value;
    dGoodAmountColor.value = Colors.transparent;
    dGoodAmountTextColor = ut.tt.value;
    dAllTheyDoColor.value = Colors.transparent;
    dAllTheyDoTextColor = ut.tt.value;
  }
}
