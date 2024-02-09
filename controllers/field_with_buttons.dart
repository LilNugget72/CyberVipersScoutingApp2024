import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

UserTheme ut = Get.find();
SheetValues sv = Get.find();

class TouchField extends GetxController {
  Rx<Color> filling = Colors.transparent.obs;

  Rx<Color> pos1 = Colors.transparent.obs; //near amp
  Rx<Color> pos2 = Colors.transparent.obs; //middle of speaker
  Rx<Color> pos3 = Colors.transparent.obs; //closest to the source

  Rx<Color> note1 = Colors.transparent.obs;
  Rx<Color> note2 = Colors.transparent.obs;
  Rx<Color> note3 = Colors.transparent.obs;
  Rx<Color> note4 = Colors.transparent.obs;
  Rx<Color> note5 = Colors.transparent.obs;
  Rx<Color> note6 = Colors.transparent.obs;
  Rx<Color> note7 = Colors.transparent.obs;
  Rx<Color> note8 = Colors.transparent.obs;
  /* quick side note
   I came across an issue where I couldn't use the button class inside the Stack 
   when I made it an ink widget from a container 
   The solution i found for this was to make the image an ink and that fixed it
   if this happens with something outside an image try to make it use ink or inkwell */
  blueSide() {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image:
                const AssetImage('lib/assets/2160xDarkCroppedFixed - Blue.png'),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -0.88),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                position(
                  spot: sv.posSource,
                  width: 55,
                  height: 78,
                  color: pos3,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 41, 6, 0),
                  child: position(
                    spot: sv.posCenter,
                    width: 80,
                    height: 40,
                    color: pos2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: position(
                    spot: sv.posAmp,
                    width: 50,
                    height: 80,
                    color: pos1,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(-0.275, -0.349),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 28),
                  child: button(pickedNote: sv.note1, noteColor: note3),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 27),
                  child: button(pickedNote: sv.note2, noteColor: note2),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 71.5),
                  child: button(pickedNote: sv.note3, noteColor: note1),
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(-0.275, 0.83),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 38),
                  child: button(pickedNote: sv.note4, noteColor: note8),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 38),
                  child: button(pickedNote: sv.note5, noteColor: note7),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 38),
                  child: button(pickedNote: sv.note6, noteColor: note6),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 37),
                  child: button(pickedNote: sv.note7, noteColor: note5),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 51.5),
                  child: button(pickedNote: sv.note8, noteColor: note4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  redSide() {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image:
                const AssetImage('lib/assets/2160xDarkCroppedFixed - Red.png'),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -0.99),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 58),
                  child: position(
                    spot: sv.posAmp,
                    width: 50,
                    height: 80,
                    color: pos1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 42, 6, 0),
                  child: position(
                    spot: sv.posCenter,
                    width: 80,
                    height: 40,
                    color: pos2,
                  ),
                ),
                position(
                  spot: sv.posSource,
                  width: 55,
                  height: 80,
                  color: pos3,
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(-0.275, -0.406),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 66),
                  child: button(pickedNote: sv.note1, noteColor: note1),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 33),
                  child: button(pickedNote: sv.note2, noteColor: note2),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 33.5),
                  child: button(pickedNote: sv.note3, noteColor: note3),
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
                  padding: const EdgeInsets.only(left: 45),
                  child: button(pickedNote: sv.note4, noteColor: note4),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 44.5),
                  child: button(pickedNote: sv.note5, noteColor: note5),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 44),
                  child: button(pickedNote: sv.note6, noteColor: note6),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 44.5),
                  child: button(pickedNote: sv.note7, noteColor: note7),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 44),
                  child: button(pickedNote: sv.note8, noteColor: note8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  toggleNoteFilling(
      {required RxBool pickedNote, required Rx<Color> noteColor}) {
    if (pickedNote.value == false) {
      pickedNote.value = true;
      noteColor.value = ut.buttonColor.value;
    } else {
      pickedNote.value = false;
      noteColor.value = Colors.transparent;
    }
  }

  button({required RxBool pickedNote, required Rx<Color> noteColor}) {
    return InkWell(
      splashColor: Colors.grey,
      borderRadius: BorderRadius.circular(60),
      onTap: () {
        toggleNoteFilling(pickedNote: pickedNote, noteColor: noteColor);
      },
      child: Obx(
        () => Ink(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            border: Border.all(color: ut.buttonColor.value, width: 3),
            color: noteColor.value,
          ),
        ),
      ),
    );
  }

  toggleSpotFilling({required RxBool spot, required Rx<Color> posColor}) {
    if (spot.value == false) {
      spot.value = true;
      posColor.value = ut.buttonColor.value;
    } else {
      spot.value = false;
      posColor.value = Colors.transparent;
    }
  }

  position(
      {required RxBool spot,
      required double width,
      required double height,
      required Rx<Color> color}) {
    return InkWell(
        borderRadius: BorderRadius.circular(15),
        splashColor: ut.buttonColor.value,
        splashFactory: InkRipple.splashFactory,
        onTap: () => toggleSpotFilling(spot: spot, posColor: color),
        child: Obx(
          () => Ink(
            decoration: BoxDecoration(
                border: Border.all(color: ut.buttonColor.value, width: 3),
                borderRadius: BorderRadius.circular(15),
                color: color.value),
            width: width,
            height: height,
          ),
        ));
  }
}
