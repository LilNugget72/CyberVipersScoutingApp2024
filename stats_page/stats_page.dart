import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();
    UserTheme ut = Get.find();
    return Scaffold(
      appBar: rw.ab(title: 'Stats Page'),
      drawer: rw.d(),
      body: Center(
          child: Obx(
        () => Text(
          'IM THE SCOUTING HOME PAGE',
          style: TextStyle(color: ut.tt.value),
        ),
      )),
      bottomNavigationBar: rw.bnb(),
    );
  }
}
