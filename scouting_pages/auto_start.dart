import 'package:cyberviperscoutingapp2024/controllers/field_with_buttons.dart';
import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutoStart extends StatelessWidget {
  const AutoStart({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();
    SheetValues sv = Get.find();
    TouchField tf = Get.put(TouchField());
    return Scaffold(
      appBar: rw.ab(title: 'Auto Position'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          tf.redSide(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              rw.valueToggle(
                  title: 'Leave', value: sv.leave, width: 188, height: 100),
              const SizedBox(
                width: 15,
              ),
              rw.valueToggle(
                  value: sv.preloaded,
                  title: 'Prealoaded?',
                  width: 188,
                  height: 100)
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sv.valueCard(value: sv.autoAmp, title: 'Amp'),
              sv.valueCard(value: sv.autoSpeaker, title: 'Speaker')
            ],
          )
        ],
      ),
    );
  }
}
