import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
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
    SheetValues sv = Get.find();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ut.bars,
        systemNavigationBarColor: ut.tt.value,
        statusBarIconBrightness: ut.statbright));

    return Scaffold(
      appBar: rw.ab(title: 'Home Page'),
      drawer: rw.d(),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Obx(
            () => TextField(
              controller: sv.scoutName,
              textAlign: TextAlign.center,
              enabled: true,
              cursorColor: ut.tt.value,
              style: TextStyle(
                  color: ut.tt.value, fontFamily: 'NotoSans', fontSize: 20),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: ut.tt.value)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ut.tt.value)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ut.tt.value))),
            ),
          ),
        ),
      ),
      bottomNavigationBar: rw.bnb(),
    );
  }
}
