import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHub extends StatelessWidget {
  const AdminHub({super.key});
  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();
    SheetValues sv = Get.find();
    UserTheme ut = Get.find();
    return Scaffold(
      appBar: rw.ab(title: 'Admin Hub'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 55),
            child: Center(
              child: Text(
                '0/6 in Lobby',
                style: TextStyle(
                    color: ut.tt.value, fontFamily: 'NotoSans', fontSize: 40),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Match',
                  style: TextStyle(color: ut.tt.value, fontSize: 50),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: const Color.fromARGB(225, 176, 171, 171),
                    onTap: () {
                      sv.matchNum--;
                      if (sv.matchNum.value < 0) {
                        sv.matchNum.value = 0;
                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          color: ut.tt.value,
                          borderRadius: BorderRadius.circular(20)),
                      width: 75,
                      height: 75,
                      child: const Icon(
                        Icons.subdirectory_arrow_left,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Center(
                      child: Obx(
                        () => Text(
                          sv.matchNum.value.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 80),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: const Color.fromARGB(225, 176, 171, 171),
                    onTap: () {
                      sv.matchNum++;
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          color: ut.tt.value,
                          borderRadius: BorderRadius.circular(20)),
                      width: 75,
                      height: 75,
                      child: const Icon(
                        Icons.subdirectory_arrow_right,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          GestureDetector(
            onTap: () {
              print(sv.matchNum.value);
            },
            child: Container(
              width: 260,
              height: 130,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(18)),
              child: const Center(
                child: Text(
                  'GO!!!',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSans',
                      fontSize: 56),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Get.off(() => const HomePage());
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: 350,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(40)),
                  child: const Center(
                    child: Text(
                      'Close the Lobby',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSans',
                          fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
