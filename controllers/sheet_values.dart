import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

ReuseWid rw = Get.find();
UserTheme ut = Get.find();

class SheetValues extends GetxController {
  RxInt matchNum = 1.obs;
  RxString teamName = ''.obs;
  RxInt teamNum = 1.obs;

  RxBool posAmp = false.obs;
  RxBool posCenter = false.obs;
  RxBool posBetween = false.obs;
  RxBool posSource = false.obs;

  RxBool note1 = false.obs; //note closest to the amp
  RxBool note2 = false.obs;
  RxBool note3 = false.obs; //note farthest to the amp

  RxBool note4 = false.obs; //note closest to the amp on the bottom
  RxBool note5 = false.obs;
  RxBool note6 = false.obs;
  RxBool note7 = false.obs;
  RxBool note8 = false.obs; //note farthest to the amp bottom

  RxBool leave = false.obs;

  RxInt autoAmp = 0.obs;
  RxInt teleopAmp = 0.obs;
  RxInt ampMissed = 0.obs;

  RxInt autoSpeaker = 0.obs;
  RxInt teleopSpeaker = 0.obs;
  RxInt speakerMissed = 0.obs;

  RxInt trap = 0.obs;
  RxInt trapMissed = 0.obs;

  RxBool dNone = true.obs;
  RxBool dSlight = false.obs;
  RxBool dModest = false.obs;
  RxBool dGenerous = false.obs;
  RxBool dExclusively = false.obs;

  RxBool leftStage = false.obs;
  RxBool centerStage = false.obs;
  RxBool rightStage = false.obs;

  RxBool park = false.obs;
  RxBool onstage = false.obs;
  RxBool harmony = false.obs;

  final scoutName = TextEditingController();
  final comments = TextEditingController();

  final teamNumber = TextEditingController();
  final matchNumber = TextEditingController();

  RxMap eventTeams = {}.obs;

  RxString teamListHint = 'Select a team'.obs;

  RxString eventKey = ''.obs;
  RxList teamXList = [].obs;

  RxInt selectedTeamNumber = 0.obs;
  RxList selectedTeamValue = [].obs;

  RxBool isDistrict = false.obs;

  RxMap regionalEvents = {}.obs;
  RxList regionalEventsKeys = [].obs;

  valueCard({required RxInt value, required String title}) {
    return Stack(
      children: [
        Ink(
          decoration: BoxDecoration(
            color: ut.buttonColor.value,
            borderRadius: BorderRadius.circular(18.r),
          ),
          width: 165.w,
          height: 186.h,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSans',
                      fontSize: 40),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Obx(
                      () => Text(
                        value.value.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'NotoSans',
                            fontSize: 45),
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 11.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(60.r),
                        splashColor: Colors.grey[300],
                        onTap: () {
                          value--;
                          if (value < 0) {
                            value.value = 0;
                          }
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              color: ut.buttonColor.value,
                              borderRadius: BorderRadius.circular(60.r),
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          width: 50.w,
                          height: 50.w,
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(60.r),
                        splashColor: Colors.grey[300],
                        onTap: () {
                          value++;
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              color: ut.buttonColor.value,
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(60.r)),
                          width: 50.w,
                          height: 50.w,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  finished() {
    matchNum.value = 1;
    teamName.value = '';
    teamNum.value = 1;

    posAmp.value = false;
    posCenter.value = false;
    posBetween.value = false;
    posSource.value = false;

    note1.value = false; //note closest to the amp
    note2.value = false;
    note3.value = false; //note farthest to the amp

    note4.value = false; //note closest to the amp on the bottom
    note5.value = false;
    note6.value = false;
    note7.value = false;
    note8.value = false; //note farthest to the amp bottom

    leave.value = false;

    autoAmp.value = 0;
    teleopAmp.value = 0;
    ampMissed.value = 0;

    autoSpeaker.value = 0;
    teleopSpeaker.value = 0;
    speakerMissed.value = 0;

    trap.value = 0;
    trapMissed.value = 0;

    leftStage.value = false;
    centerStage.value = false;
    rightStage.value = false;

    dNone.value = true;
    dSlight.value = false;
    dModest.value = false;
    dGenerous.value = false;
    dExclusively.value = false;

    park.value = false;
    onstage.value = false;
    harmony.value = false;

    comments.clear();
  }
}
