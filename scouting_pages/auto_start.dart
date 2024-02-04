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
    return Scaffold(
        appBar: rw.ab(title: 'Auto Position'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              height: 400,
              image: AssetImage('lib/assets/2160xDarkCroppedFixed - Red.png'),
            ),
            rw.valueToggle(title: 'Leave', value: sv.leave),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                sv.valueCard(value: sv.autoAmp, title: 'Amp'),
                sv.valueCard(value: sv.autoSpeaker, title: 'Speaker')
              ],
            )
          ],
        ));
  }
}
