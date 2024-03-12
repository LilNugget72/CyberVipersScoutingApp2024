import 'dart:math';

import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StatsFields extends GetxController {
  UserTheme ut = Get.find();

  RxString stats1 = ''.obs;
  RxString stats2 = ''.obs;
  RxString stats3 = ''.obs;

  RxString autoAmp = ''.obs;
  RxString autoSpeak = ''.obs;

  RxString viewNote1 = ''.obs;
  RxString viewNote2 = ''.obs;
  RxString viewNote3 = ''.obs;
  RxString viewNote4 = ''.obs;
  RxString viewNote5 = ''.obs;
  RxString viewNote6 = ''.obs;
  RxString viewNote7 = ''.obs;
  RxString viewNote8 = ''.obs;

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

  Rx<Color> stage1 = Colors.transparent.obs; //left
  Rx<Color> stage2 = Colors.transparent.obs; //center
  Rx<Color> stage3 = Colors.transparent.obs; //right

  Rx<Color> none = Colors.transparent.obs;
  Rx<Color> slight = Colors.transparent.obs;
  Rx<Color> modest = Colors.transparent.obs;
  Rx<Color> generous = Colors.transparent.obs;
  Rx<Color> exclusively = Colors.transparent.obs;

  RxString parked = ''.obs;
  RxString harmony = ''.obs;

  RxString comments = ''.obs;
  RxString scouter = ''.obs;

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
          fit: BoxFit.fill,
          height: 370.h,
          width: 360.w,
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
          fit: BoxFit.fill,
          height: 370.h,
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
          left: 51.5.w,
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
            left: 63.w, top: 135.h, child: statsNoteTimeline(value: viewNote1)),
        Positioned(
          top: 135.h,
          left: 125.w,
          child: statsNoteTimeline(value: viewNote2),
        ),
        Positioned(
            top: 99.h,
            right: 115.w,
            child: statsNoteTimeline(value: viewNote3)),
        Positioned.fill(
          top: 300.h,
          left: 32.w,
          child: Row(
            children: [
              statsButton(
                noteColor: note4InStats,
              ),
              Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: statsButton(
                  noteColor: note5InStats,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 37.5.w),
                child: statsButton(
                  noteColor: note6InStats,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: statsButton(
                  noteColor: note7InStats,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: statsButton(
                  noteColor: note8InStats,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 62.h,
          left: 40.w,
          child: statsNoteTimeline(value: viewNote4),
        ),
        Positioned(
          bottom: 62.h,
          left: 114.w,
          child: statsNoteTimeline(value: viewNote5),
        ),
        Positioned(
          bottom: 62.h,
          left: 186.w,
          child: statsNoteTimeline(value: viewNote6),
        ),
        Positioned(
          bottom: 62.h,
          left: 258.w,
          child: statsNoteTimeline(value: viewNote7),
        ),
        Positioned(
          bottom: 62.h,
          left: 330.w,
          child: statsNoteTimeline(value: viewNote8),
        ),
      ],
    );
  }

  statsEndStages({
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

  statsRedStage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          fit: BoxFit.fill,
          height: 300.h,
          width: 360.w,
          image: const AssetImage('lib/assets/Stage - Red.png'),
        ),
        Positioned(
          left: 20.w,
          top: 60.w,
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              SizedBox(
                width: 8.w,
              ),
              const Text(
                'Amp',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NotoSans',
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: 10.w,
          top: 60.w,
          child: Row(
            children: [
              const Text(
                'Source',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NotoSans',
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
        Positioned(
          right: 55.w,
          bottom: 130.h,
          child: Transform.rotate(
            angle: (55 * pi / 180),
            child: statsEndStages(
              width: 120.w,
              height: 50.h,
              color: stage1,
            ),
          ),
        ),
        Positioned(
          bottom: 22.h,
          right: 116.w,
          child: statsEndStages(
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
            child: statsEndStages(
              width: 120.w,
              height: 50.h,
              color: stage3,
            ),
          ),
        ),
      ],
    );
  }

  statsBlueStage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          fit: BoxFit.fill,
          height: 300.h,
          width: 360.w,
          image: const AssetImage('lib/assets/Stage - Blue.png'),
        ),
        Positioned(
          left: 20.w,
          top: 60.h,
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              SizedBox(
                width: 8.w,
              ),
              const Text(
                'Source',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NotoSans',
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: 30.w,
          top: 60.h,
          child: Row(
            children: [
              const Text(
                'Amp',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NotoSans',
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
        Positioned(
          right: 55.w,
          bottom: 130.h,
          child: Transform.rotate(
            angle: (55 * pi / 180),
            child: statsEndStages(
              width: 120.w,
              height: 50.h,
              color: stage1,
            ),
          ),
        ),
        Positioned(
          bottom: 22.h,
          right: 116.w,
          child: statsEndStages(
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
            child: statsEndStages(
              width: 120.w,
              height: 50.h,
              color: stage3,
            ),
          ),
        ),
      ],
    );
  }

  defenseButtons({
    required String title,
    required double width,
    required Rx<Color> fillColor,
  }) {
    return Obx(
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
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontFamily: 'NotoSans'),
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
          defenseButtons(
            title: 'None',
            width: 50.w,
            fillColor: none,
          ),
          defenseButtons(title: 'Slight', width: 55.w, fillColor: slight),
          defenseButtons(title: 'Modest', width: 63.w, fillColor: modest),
          defenseButtons(title: 'Generous', width: 78.w, fillColor: generous),
          defenseButtons(
              title: 'Exclusively', width: 83.w, fillColor: exclusively)
        ],
      ),
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

    stage1.value = Colors.transparent;
    stage2.value = Colors.transparent;
    stage3.value = Colors.transparent;

    none.value = Colors.transparent;
    slight.value = Colors.transparent;
    modest.value = Colors.transparent;
    generous.value = Colors.transparent;
    exclusively.value = Colors.transparent;

    stats1.value = '';
    stats2.value = '';
    stats3.value = '';

    autoAmp.value = '';
    autoSpeak.value = '';

    parked.value = '';
    harmony.value = '';

    comments.value = '';
    scouter.value = '';
  }
}
