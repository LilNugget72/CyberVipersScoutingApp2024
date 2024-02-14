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
                  spot: sv.posSource,
                  width: 45.w,
                  height: 73.h,
                  color: pos3,
                  selectedZone: sv.posSource),
              Padding(
                padding: EdgeInsets.fromLTRB(4.w, 40.h, 4.w, 0),
                child: startingZone(
                    spot: sv.posCenter,
                    width: 80.w,
                    height: 35.h,
                    color: pos2,
                    selectedZone: sv.posCenter),
              ),
              startingZone(
                  spot: sv.posAmp,
                  width: 45.w,
                  height: 73.h,
                  color: pos1,
                  selectedZone: sv.posAmp)
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
                  spot: sv.posAmp,
                  width: 45.w,
                  height: 80.h,
                  color: pos1,
                  selectedZone: sv.posAmp),
              Padding(
                padding: EdgeInsets.fromLTRB(4.w, 40.h, 4.w, 0),
                child: startingZone(
                    spot: sv.posCenter,
                    width: 80.w,
                    height: 40.h,
                    color: pos2,
                    selectedZone: sv.posCenter),
              ),
              startingZone(
                  spot: sv.posSource,
                  width: 45.w,
                  height: 80.h,
                  color: pos3,
                  selectedZone: sv.posSource)
            ],
          ),
        ),
        Positioned.fill(
          left: 51.5.w,
          bottom: 148.h,
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
      borderRadius: BorderRadius.circular(60.r),
      onTap: () {
        toggleNoteFilling(pickedNote: pickedNote, noteColor: noteColor);
      },
      child: Obx(
        () => Container(
          width: 35.w,
          height: 35.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90.r),
            border: Border.all(color: ut.buttonColor.value, width: 3.w),
            color: noteColor.value,
          ),
        ),
      ),
    );
  }

  toggleSpotFilling({required Rx<Color> posColor}) {
    if (posColor.value == Colors.transparent) {
      posColor.value = ut.buttonColor.value;
    } else {
      posColor.value = Colors.transparent;
    }
  }

  startingZone({
    required RxBool spot,
    required double width,
    required double height,
    required Rx<Color> color,
    required RxBool selectedZone,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      splashColor: ut.buttonColor.value,
      splashFactory: InkSplash.splashFactory,
      onTap: () {
        toggleSpotFilling(posColor: color);
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
              border: Border.all(color: ut.buttonColor.value, width: 3.w),
              borderRadius: BorderRadius.circular(15.r),
              color: color.value),
          width: width,
          height: height,
        ),
      ),
    );
  }
}
