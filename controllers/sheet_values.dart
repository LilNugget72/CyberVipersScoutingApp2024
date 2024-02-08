import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ReuseWid rw = Get.find();
UserTheme ut = Get.find();

class SheetValues extends GetxController {
  RxBool posAmp = false.obs;
  RxBool posCenter = false.obs;
  RxBool posSource = false.obs;

  RxBool note1 = false.obs;
  RxBool note2 = false.obs;
  RxBool note3 = false.obs;
  RxBool note4 = false.obs;
  RxBool note5 = false.obs;
  RxBool note6 = false.obs;
  RxBool note7 = false.obs;
  RxBool note8 = false.obs;

  RxBool leave = false.obs;
  RxBool preloaded = false.obs;
  RxInt autoAmp = 0.obs;
  RxInt autoSpeaker = 0.obs;

  RxInt teleopAmp = 0.obs;
  RxInt teleopSpeaker = 0.obs;

  RxBool park = false.obs;
  RxBool onstage = false.obs;
  RxInt trap = 0.obs;
  RxString comments = ''.obs;

  RxInt matchNum = 1.obs;

  final scoutName = TextEditingController();

  valueCard({required RxInt value, required String title}) {
    return Stack(
      children: [
        Ink(
          decoration: BoxDecoration(
              color: ut.buttonColor.value,
              borderRadius: BorderRadius.circular(18)),
          width: 200,
          height: 240,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSans',
                      fontSize: 45),
                ),
              ),
              Obx(
                () => Align(
                  alignment: Alignment.center,
                  child: Text(
                    value.value.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 60),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          value--;
                          if (value < 0) {
                            value.value = 0;
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.white,
                          ),
                          width: 70,
                          height: 70,
                          child: Icon(
                            Icons.remove,
                            color: ut.buttonColor.value,
                            size: 40,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          value++;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(60)),
                          width: 70,
                          height: 70,
                          child: Icon(
                            Icons.add,
                            color: ut.buttonColor.value,
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
}
