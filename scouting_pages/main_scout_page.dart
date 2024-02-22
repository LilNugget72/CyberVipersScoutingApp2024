import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/read_sheet.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/auto_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScoutPage extends StatelessWidget {
  const ScoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();
    UserTheme ut = Get.find();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ut.bars,
        systemNavigationBarColor: ut.bars,
        statusBarBrightness: ut.statbright));

    return Scaffold(
      drawer: rw.d(),
      appBar: rw.ab(
        title: 'Scouting Page Lobby',
      ),
      body: Column(
        children: [
          rw.line(),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  final thing = await totalValueInList(
                      team: 8717, column: 'AUTO AMP NOTES');
                  // Get.to(() => const AutoStart());
                  print('the thing is $thing');
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.redAccent),
                  width: 150,
                  height: 150,
                  child: const Center(
                      child: Text(
                    'Ready to Scout?',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: rw.bnb(),
    );
  }
}
