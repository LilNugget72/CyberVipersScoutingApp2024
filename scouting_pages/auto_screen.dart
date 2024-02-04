import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutoScreen extends StatelessWidget {
  const AutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();
    SheetValues sv = Get.find();
    return Scaffold(
        appBar: rw.ab(title: "Auto"),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              sv.valueCard(value: sv.autoAmp, title: 'Amp'),
              sv.valueCard(value: sv.autoSpeaker, title: 'Speaker')
            ])
          ],
        ));
  }
}
