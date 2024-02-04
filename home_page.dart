import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.put(ReuseWid());
    UserTheme ut = Get.put(UserTheme());
    if (1 == 1) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: ut.bars,
          systemNavigationBarColor: ut.tt.value,
          statusBarIconBrightness: ut.statbright));
    }
    return Scaffold(
      appBar: rw.ab(title: 'Home Page'),
      drawer: rw.d(),
      bottomNavigationBar: Obx(() => rw.bnb()),
    );
  }
}
