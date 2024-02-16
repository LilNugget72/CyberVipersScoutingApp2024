import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

UserTheme ut = Get.put(UserTheme());

class EndgameDefense extends GetxController {
  RxBool dNone = false.obs;
  Rx<Color> dNoneColor = Colors.transparent.obs;
  Color dNoneTextColor = ut.tt.value;
  RxBool dSlight = false.obs;
  Rx<Color> dSlightColor = Colors.transparent.obs;
  Color dSlightTextColor = ut.tt.value;
  RxBool dModerate = false.obs;
  Rx<Color> dModerateColor = Colors.transparent.obs;
  Color dModerateTextColor = ut.tt.value;
  RxBool dGoodAmount = false.obs;
  Rx<Color> dGoodAmountColor = Colors.transparent.obs;
  Color dGoodAmountTextColor = ut.tt.value;
  RxBool dAllTheyDo = false.obs;
  Rx<Color> dAllTheyDoColor = Colors.transparent.obs;
  Color dAllTheyDoTextColor = ut.tt.value;

  toggleD() {
    dNoneColor.value = Colors.transparent;
    dSlightColor.value = Colors.transparent;
    dModerateColor.value = Colors.transparent;
    dGoodAmountColor.value = Colors.transparent;
    dAllTheyDoColor.value = Colors.transparent;

    dNone.value = false;
    dSlight.value = false;
    dModerate.value = false;
    dGoodAmount.value = false;
    dAllTheyDo.value = false;
    update();
  }

  toggleDefense(
      {required RxBool defense,
      required String title,
      required double width,
      required Rx<Color> fillColor,
      required Rx<Color> textColor}) {
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(10.r),
      onTap: () {
        if (defense.isFalse) {
          toggleD();
          fillColor.value = ut.buttonColor.value;
          textColor.value = Colors.white;
          defense.value = true;

          if (ut.tt.value == Colors.white) {
            dNoneTextColor = Colors.white;
            dSlightTextColor = Colors.white;
            dModerateTextColor = Colors.white;
            dGoodAmountTextColor = Colors.white;
            dAllTheyDoTextColor = Colors.white;
          } else {
            dNoneTextColor = Colors.black;
            dSlightTextColor = Colors.black;
            dModerateTextColor = Colors.black;
            dGoodAmountTextColor = Colors.black;
            dAllTheyDoTextColor = Colors.black;
          }
        }

        print(textColor);

        print(defense);
        print(dNoneTextColor);
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
                  color: textColor.value, fontSize: 15, fontFamily: 'NotoSans'),
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
              defense: dNone,
              title: 'None',
              width: 50.w,
              fillColor: dNoneColor,
              textColor: dNoneTextColor.obs),
          toggleDefense(
              defense: dSlight,
              title: 'Slight',
              width: 50.w,
              fillColor: dSlightColor,
              textColor: dSlightTextColor.obs),
          toggleDefense(
              defense: dModerate,
              title: 'Moderate',
              width: 75.w,
              fillColor: dModerateColor,
              textColor: dModerateTextColor.obs),
          toggleDefense(
              defense: dGoodAmount,
              title: 'Good Amount',
              width: 104.w,
              fillColor: dGoodAmountColor,
              textColor: dGoodAmountTextColor.obs),
          toggleDefense(
              defense: dAllTheyDo,
              title: 'All They Do',
              width: 81.w,
              fillColor: dAllTheyDoColor,
              textColor: dAllTheyDoTextColor.obs)
        ],
      ),
    );
  }
}
