import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

UserTheme ut = Get.find();

class TouchField extends GetxController {
  Rx<Color> filling = Colors.transparent.obs;
  RxBool pickedNote = false.obs;
  /* quick side note
   I came across an issue where I couldn't use the button class inside the Stack 
   when I made it an ink widget from a container 
   The solution i found for this was to make the image an ink and that fixed it
   if this happens with something outside an image try to make it use ink or inkwell */
  redSide() {
    return Expanded(
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          Ink.image(
            height: 410,
            image:
                const AssetImage('lib/assets/2160xDarkCroppedFixed - Red.png'),
          ),
          Align(
            alignment: const Alignment(-0.275, -0.406),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 68.5),
                  child: button(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: button(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: button(),
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(-0.275, 0.88),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 47),
                  child: button(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 43),
                  child: button(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 43),
                  child: button(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 43),
                  child: button(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 42),
                  child: button(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  toggleFilling() {
    if (pickedNote.value == false) {
      pickedNote.value = true;
      filling.value = ut.buttonColor.value;
      update();
    } else {
      pickedNote.value = false;
      filling.value = Colors.transparent;
    }
  }

  button() {
    return InkWell(
      splashColor: Colors.grey,
      borderRadius: BorderRadius.circular(60),
      onTap: () {
        toggleFilling();
      },
      child: Obx(
        () => Ink(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            border: Border.all(color: ut.buttonColor.value, width: 3),
            color: filling.value,
          ),
        ),
      ),
    );
  }
}
