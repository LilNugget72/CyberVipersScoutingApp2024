import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StatsFields extends GetxController {
  UserTheme ut = Get.find();
  RxString viewNote1 = '1'.obs;
  RxString viewNote2 = '2'.obs;
  RxString viewNote3 = '3'.obs;
  RxString viewNote4 = '4'.obs;
  RxString viewNote5 = '5'.obs;
  RxString viewNote6 = '6'.obs;
  RxString viewNote7 = '7'.obs;
  RxString viewNote8 = '8'.obs;

  Rx<Color> viewZone1 = Colors.transparent.obs; //near amp
  Rx<Color> viewZone2 = Colors.transparent.obs; //middle of speaker
  Rx<Color> viewZone3 = Colors.transparent.obs; //between speaker and source
  Rx<Color> viewZone4 = Colors.transparent.obs; //closest to the source
  Rx<Color> note1InStats = Colors.transparent.obs;
  Rx<Color> note2InStats = Colors.transparent.obs;
  Rx<Color> note3InStats = Colors.transparent.obs;
  Rx<Color> note4InStats = Colors.transparent.obs;
  Rx<Color> note5InStats = Colors.transparent.obs;
  Rx<Color> note6InStats = Colors.transparent.obs;
  Rx<Color> note7InStats = Colors.transparent.obs;
  Rx<Color> note8InStats = Colors.transparent.obs;

  statsAutoZone({
    required double width,
    required double height,
    required Rx<Color> color,
  }) {
    return Obx(
      () => Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: ut.buttonColor.value, width: 4.w),
            color: color.value),
        width: width,
        height: height,
      ),
    );
  }

  statsNoteTimeline({required RxString value}) {
    return Obx(
      () => Text(
        value.value,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'NotoSans',
          fontSize: 25,
        ),
      ),
    );
  }

  statsButton({required Rx<Color> noteColor}) {
    return Obx(
      () => Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.r),
            border: Border.all(color: ut.buttonColor.value, width: 3.w),
            color: noteColor.value),
        width: 35.w,
        height: 35.w,
      ),
    );
  }

  statsBlueAuto() {
    return Stack(
      children: [
        Ink.image(
          height: 370.h,
          centerSlice: Rect.largest,
          image: const AssetImage('lib/assets/Field - Blue.png'),
        ),
        Positioned(
          top: 18.h,
          right: 40.w,
          child: Row(
            children: [
              statsAutoZone(
                width: 70.w,
                height: 68.h,
                color: viewZone4,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 5.w,
                ),
                child: statsAutoZone(
                  width: 45.w,
                  height: 68.h,
                  color: viewZone3,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(4.w, 35.h, 4.w, 0),
                child: statsAutoZone(
                  width: 80.w,
                  height: 35.h,
                  color: viewZone2,
                ),
              ),
              statsAutoZone(
                width: 45.w,
                height: 68.h,
                color: viewZone1,
              )
            ],
          ),
        ),
        Positioned.fill(
          left: 154.w,
          bottom: 119.h,
          child: Row(
            children: [
              statsButton(noteColor: note3InStats),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: statsButton(noteColor: note2InStats),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: statsButton(noteColor: note1InStats),
              ),
            ],
          ),
        ),
        Positioned(
            right: 220.w,
            top: 105.h,
            child: statsNoteTimeline(value: viewNote3)),
        Positioned(
          top: 150.h,
          right: 62.w,
          child: Row(
            children: [
              statsNoteTimeline(value: viewNote2),
              SizedBox(
                width: 47.w,
              ),
              statsNoteTimeline(value: viewNote1),
            ],
          ),
        ),
        Positioned.fill(
          top: 283.h,
          left: 16.5.w,
          child: Row(
            children: [
              statsButton(noteColor: note8InStats),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: statsButton(noteColor: note7InStats)),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: statsButton(noteColor: note6InStats)),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: statsButton(noteColor: note5InStats)),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: statsButton(noteColor: note4InStats)),
            ],
          ),
        ),
        Positioned(
          bottom: 65.h,
          left: 28.w,
          child: statsNoteTimeline(value: viewNote8),
        ),
        Positioned(
          bottom: 65.h,
          left: 97.w,
          child: statsNoteTimeline(value: viewNote7),
        ),
        Positioned(
          bottom: 65.h,
          left: 165.w,
          child: statsNoteTimeline(value: viewNote6),
        ),
        Positioned(
          bottom: 65.h,
          left: 235.w,
          child: statsNoteTimeline(value: viewNote5),
        ),
        Positioned(
          bottom: 65.h,
          left: 304.w,
          child: statsNoteTimeline(value: viewNote4),
        ),
      ],
    );
  }

  statsRedAuto() {
    return Stack(
      children: [
        Ink.image(
          height: 370.h,
          centerSlice: Rect.largest,
          image: const AssetImage('lib/assets/Field - Red.png'),
        ),
        Positioned(
          top: 5.h,
          left: 40.w,
          child: Row(
            children: [
              statsAutoZone(
                width: 45.w,
                height: 68.h,
                color: viewZone1,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.w, 30.h, 5.w, 0),
                child: statsAutoZone(
                  width: 80.w,
                  height: 35.h,
                  color: viewZone2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: statsAutoZone(
                  width: 45.w,
                  height: 68.h,
                  color: viewZone3,
                ),
              ),
              statsAutoZone(
                width: 70.w,
                height: 68.h,
                color: viewZone4,
              )
            ],
          ),
        ),
        Positioned.fill(
          left: 51.w,
          bottom: 138.h,
          child: Row(
            children: [
              statsButton(noteColor: note1InStats),
              Padding(
                padding: EdgeInsets.only(left: 27.w),
                child: statsButton(noteColor: note2InStats),
              ),
              Padding(
                padding: EdgeInsets.only(left: 28.w),
                child: statsButton(noteColor: note3InStats),
              )
            ],
          ),
        ),
        Positioned(
            right: 220.w,
            top: 105.h,
            child: statsNoteTimeline(value: viewNote3)),
        Positioned(
          top: 150.h,
          right: 62.w,
          child: Row(
            children: [
              statsNoteTimeline(value: viewNote2),
              SizedBox(
                width: 47.w,
              ),
              statsNoteTimeline(value: viewNote1),
            ],
          ),
        ),
        Positioned.fill(
          top: 283.h,
          left: 16.5.w,
          child: Row(
            children: [
              statsButton(noteColor: note8InStats),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: statsButton(noteColor: note7InStats)),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: statsButton(noteColor: note6InStats)),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: statsButton(noteColor: note5InStats)),
              Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: statsButton(noteColor: note4InStats)),
            ],
          ),
        ),
        Positioned(
          bottom: 65.h,
          left: 28.w,
          child: statsNoteTimeline(value: viewNote8),
        ),
        Positioned(
          bottom: 65.h,
          left: 97.w,
          child: statsNoteTimeline(value: viewNote7),
        ),
        Positioned(
          bottom: 65.h,
          left: 165.w,
          child: statsNoteTimeline(value: viewNote6),
        ),
        Positioned(
          bottom: 65.h,
          left: 235.w,
          child: statsNoteTimeline(value: viewNote5),
        ),
        Positioned(
          bottom: 65.h,
          left: 304.w,
          child: statsNoteTimeline(value: viewNote4),
        ),
      ],
    );
  }

  clearView() {
    viewNote1.value = '';
    viewNote2.value = '';
    viewNote3.value = '';
    viewNote4.value = '';
    viewNote5.value = '';
    viewNote6.value = '';
    viewNote7.value = '';
    viewNote8.value = '';

    viewZone1.value = Colors.transparent; //near amp
    viewZone2.value = Colors.transparent; //middle of speaker
    viewZone3.value = Colors.transparent; //between speaker and source
    viewZone4.value = Colors.transparent; //closest to the source
    note1InStats.value = Colors.transparent;
    note2InStats.value = Colors.transparent;
    note3InStats.value = Colors.transparent;
    note4InStats.value = Colors.transparent;
    note5InStats.value = Colors.transparent;
    note6InStats.value = Colors.transparent;
    note7InStats.value = Colors.transparent;
    note8InStats.value = Colors.transparent;
  }
}
