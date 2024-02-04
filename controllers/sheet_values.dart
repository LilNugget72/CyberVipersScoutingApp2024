import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ReuseWid rw = Get.find();

class SheetValues extends GetxController {
  RxBool leave = false.obs;
  RxInt autoAmp = 0.obs;
  RxInt autoSpeaker = 0.obs;

  RxInt teleopAmp = 0.obs;
  RxInt teleopSpeaker = 0.obs;

  RxBool park = false.obs;
  RxBool onstage = false.obs;
  RxInt trap = 0.obs;
  RxString comments = ''.obs;

  RxInt matchNum = 0.obs;

  valueCard({required RxInt value, required String title}) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 101, 179),
          borderRadius: BorderRadius.circular(18)),
      width: 200,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'NotoSans', fontSize: 45),
          ),
          Obx(
            () => Text(
              value.value.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'NotoSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 60),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  value--;
                  if (value < 0) {
                    value.value = 0;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white,
                    ),
                    width: 70,
                    height: 70,
                    child: const Icon(
                      Icons.remove,
                      color: Color.fromARGB(255, 0, 101, 179),
                      size: 40,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  value++;
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60)),
                    width: 70,
                    height: 70,
                    child: const Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 0, 101, 179),
                      size: 40,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
