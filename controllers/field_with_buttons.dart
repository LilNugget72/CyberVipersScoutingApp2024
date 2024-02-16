import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';

UserTheme ut = Get.find();
SheetValues sv = Get.find();

class TouchField extends GetxController {
  Rx<Color> filling = Colors.transparent.obs;

  Rx<Color> pos1 = Colors.transparent.obs; //near amp
  Rx<Color> pos2 = Colors.transparent.obs; //middle of speaker
  Rx<Color> pos3 = Colors.transparent.obs; //closest to the source

  Rx<Color> stage1 = Colors.transparent.obs; //left of the driver station
  Rx<Color> stage2 = Colors.transparent.obs; //the only flat part
  Rx<Color> stage3 = Colors.transparent.obs; //right of the driver station
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
   if this happens with something outside an image try to make it use ink or inkwell 
   
   HUGE THING TO KNOW
   NOT ONLY DO YOU NEED THE INK.IMAGE, BUT YOU ALSO NEED TO SET THE CENTER SLICE TO LARGEST
   (You could set it to different values but it's just better to set it to largest). ANOTHER
   THING TO NOTE IS THAT YOU SHOULD ONLY REALLY SET THE IMAGES HEIGHT NOT WIDTH JUST TO BE ON THE 
   SAFE SIDE SINCE THATS WHAT MADE IT WORK FOR ME
   */
  blueSide() {
    return Stack(
      children: [
        Ink.image(
          height: 400.h,
          centerSlice: Rect.largest,
          image:
              const AssetImage('lib/assets/2160xDarkCroppedFixed - Blue.png'),
        ),
        Positioned(
          top: 19.h,
          right: 40.w,
          child: Row(
            children: [
              startingZone(
                zone: sv.posSource,
                width: 45.w,
                height: 73.h,
                color: pos3,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(4.w, 40.h, 4.w, 0),
                child: startingZone(
                  zone: sv.posCenter,
                  width: 80.w,
                  height: 35.h,
                  color: pos2,
                ),
              ),
              startingZone(
                zone: sv.posAmp,
                width: 45.w,
                height: 73.h,
                color: pos1,
              )
            ],
          ),
        ),
        Positioned.fill(
          left: 154.w,
          bottom: 128.h,
          child: Row(
            children: [
              button(pickedNote: sv.note3, noteColor: note3),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: button(pickedNote: sv.note2, noteColor: note2),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: button(pickedNote: sv.note1, noteColor: note1),
              ),
            ],
          ),
        ),
        Positioned.fill(
          top: 306.h,
          left: 16.5.w,
          child: Row(
            children: [
              button(pickedNote: sv.note8, noteColor: note8),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: button(pickedNote: sv.note7, noteColor: note7)),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: button(pickedNote: sv.note6, noteColor: note6)),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: button(pickedNote: sv.note5, noteColor: note5)),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: button(pickedNote: sv.note4, noteColor: note4)),
            ],
          ),
        )
      ],
    );
  }

  blueStage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          height: 300.h,
          width: 360.w,
          centerSlice: Rect.largest,
          image: const AssetImage('lib/assets/Stage - Blue.png'),
        ),
        Positioned(
          right: 55.w,
          bottom: 130.h,
          child: Transform.rotate(
            angle: (55 * pi / 180),
            child: endingStage(
              stage: sv.leftStage,
              width: 120.w,
              height: 50.h,
              color: stage1,
            ),
          ),
        ),
        Positioned(
          bottom: 22.h,
          right: 116.w,
          child: endingStage(
            stage: sv.centerStage,
            width: 130.w,
            height: 50.h,
            color: stage2,
          ),
        ),
        Positioned(
          left: 55.w,
          bottom: 130.h,
          child: Transform.rotate(
            angle: (-55 * pi / 180),
            child: endingStage(
              stage: sv.rightStage,
              width: 120.w,
              height: 50.h,
              color: stage3,
            ),
          ),
        ),
      ],
    );
  }

  redSide() {
    return Stack(
      children: [
        Ink.image(
          height: 400.h,
          centerSlice: Rect.largest,
          image: const AssetImage('lib/assets/2160xDarkCroppedFixed - Red.png'),
        ),
        Positioned(
          left: 42.w,
          child: Row(
            children: [
              startingZone(
                zone: sv.posAmp,
                width: 45.w,
                height: 80.h,
                color: pos1,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(4.w, 40.h, 4.w, 0),
                child: startingZone(
                  zone: sv.posCenter,
                  width: 80.w,
                  height: 40.h,
                  color: pos2,
                ),
              ),
              startingZone(
                zone: sv.posSource,
                width: 45.w,
                height: 80.h,
                color: pos3,
              )
            ],
          ),
        ),
        Positioned.fill(
          left: 51.5.w,
          bottom: 150.h,
          child: Row(
            children: [
              button(pickedNote: sv.note1, noteColor: note1),
              Padding(
                padding: EdgeInsets.only(left: 27.5.w),
                child: button(pickedNote: sv.note2, noteColor: note2),
              ),
              Padding(
                padding: EdgeInsets.only(left: 27.5.w),
                child: button(pickedNote: sv.note3, noteColor: note3),
              ),
            ],
          ),
        ),
        Positioned.fill(
          top: 324.h,
          left: 32.w,
          child: Row(
            children: [
              button(pickedNote: sv.note4, noteColor: note4),
              Padding(
                  padding: EdgeInsets.only(left: 37.w),
                  child: button(pickedNote: sv.note5, noteColor: note5)),
              Padding(
                  padding: EdgeInsets.only(left: 37.w),
                  child: button(pickedNote: sv.note6, noteColor: note6)),
              Padding(
                  padding: EdgeInsets.only(left: 37.w),
                  child: button(pickedNote: sv.note7, noteColor: note7)),
              Padding(
                  padding: EdgeInsets.only(left: 37.w),
                  child: button(pickedNote: sv.note8, noteColor: note8)),
            ],
          ),
        )
      ],
    );
  }

  redStage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          height: 300.h,
          width: 360.w,
          centerSlice: Rect.largest,
          image: const AssetImage('lib/assets/Stage - Red.png'),
        ),
        Positioned(
          right: 55.w,
          bottom: 130.h,
          child: Transform.rotate(
            angle: (55 * pi / 180),
            child: endingStage(
              stage: sv.leftStage,
              width: 120.w,
              height: 50.h,
              color: stage1,
            ),
          ),
        ),
        Positioned(
          bottom: 22.h,
          right: 116.w,
          child: endingStage(
            stage: sv.centerStage,
            width: 130.w,
            height: 50.h,
            color: stage2,
          ),
        ),
        Positioned(
          left: 55.w,
          bottom: 130.h,
          child: Transform.rotate(
              angle: (-55 * pi / 180),
              child: endingStage(
                stage: sv.rightStage,
                width: 120.w,
                height: 50.h,
                color: stage3,
              )),
        ),
      ],
    );
  }

  button({required RxBool pickedNote, required Rx<Color> noteColor}) {
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(60.r),
      onTap: () {
        if (pickedNote.value == false) {
          pickedNote.value = true;
          noteColor.value = ut.buttonColor.value;
        } else {
          pickedNote.value = false;
          noteColor.value = Colors.transparent;
        }
      },
      child: Obx(
        () => Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.r),
              border: Border.all(color: ut.buttonColor.value, width: 3.w),
              color: noteColor.value),
          width: 35.w,
          height: 35.w,
        ),
      ),
    );
  }

  startingZone({
    required RxBool zone,
    required double width,
    required double height,
    required Rx<Color> color,
  }) {
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        if (zone.isFalse) {
          toggleZone(zone: zone, color: color);
        } else {
          zone.value = false;
          color.value = Colors.transparent;
        }
      },
      child: Obx(
        () => Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ut.buttonColor.value, width: 4.w),
              color: color.value),
          width: width,
          height: height,
        ),
      ),
    );
  }

  toggleZone({required RxBool zone, required Rx<Color> color}) {
    pos1.value = Colors.transparent;
    pos2.value = Colors.transparent;
    pos3.value = Colors.transparent;

    sv.posAmp.value = false;
    sv.posCenter.value = false;
    sv.posSource.value = false;

    zone.value = true;

    color.value = ut.buttonColor.value;
  }

  endingStage({
    required RxBool stage,
    required double width,
    required double height,
    required Rx<Color> color,
  }) {
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        if (stage.isFalse) {
          toggleStage(stage: stage, color: color);
        } else {
          stage1.value = Colors.transparent;
          stage2.value = Colors.transparent;
          stage3.value = Colors.transparent;

          sv.leftStage.value = false;
          sv.centerStage.value = false;
          sv.rightStage.value = false;
        }
      },
      child: Obx(
        () => Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ut.buttonColor.value, width: 4.w),
              color: color.value),
          width: width,
          height: height,
        ),
      ),
    );
  }

  toggleStage({required RxBool stage, required Rx<Color> color}) {
    stage1.value = Colors.transparent;
    stage2.value = Colors.transparent;
    stage3.value = Colors.transparent;

    sv.leftStage.value = false;
    sv.centerStage.value = false;
    sv.rightStage.value = false;

    stage.value = true;
    color.value = ut.buttonColor.value;
  }
}
