import 'package:cyberviperscoutingapp2024/admin_auth.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/main_scout_page.dart';
import 'package:cyberviperscoutingapp2024/stats_page/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'google_sheets_api.dart';
import 'user.dart';

class ReuseWid extends GetxController {
  RxInt selectedIndex = 0.obs;
  UserTheme ut = Get.find();
  SheetValues sv = Get.put(SheetValues());

  valueUp({required RxInt value, String? varName}) {
    return GestureDetector(
      onTap: () {
        value++;
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60), color: Colors.white),
        width: 75,
        height: 75,
        child: const Icon(
          Icons.add,
          color: Colors.blue,
          size: 40,
        ),
      ),
    );
  }

  valueDown({required RxInt value}) {
    return GestureDetector(
        onTap: () {
          value--;
          if (value < 0) {
            value.value = 0;
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.white,
          ),
          width: 75,
          height: 75,
          child: const Icon(
            Icons.remove,
            color: Colors.blue,
            size: 40,
          ),
        ));
  }

  valueRow({required value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        valueDown(value: value),
        const SizedBox(
          width: 40,
        ),
        valueUp(value: value)
      ],
    );
  }

  showValue({required show}) {
    return Text(
      show.toString(),
      style: const TextStyle(
          color: Colors.white,
          fontSize: 60,
          fontFamily: 'NotoSans',
          fontWeight: FontWeight.bold),
    );
  }

  drawerWid({required String title, required function, required icon}) {
    return ElevatedButton(
      onPressed: function,
      style: const ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(15, 16, 0, 16)),
          backgroundColor: MaterialStatePropertyAll(Color(0x00FFFFFF)),
          splashFactory: InkSplash.splashFactory,
          overlayColor:
              MaterialStatePropertyAll(Color.fromARGB(225, 176, 171, 171)),
          elevation: MaterialStatePropertyAll(0)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(
            width: 12,
          ),
          Obx(
            () => Text(title,
                style: TextStyle(
                    fontSize: 25, color: ut.tt.value, fontFamily: 'NotoSans')),
          ),
          const SizedBox(
            height: double.minPositive,
            width: double.minPositive,
          )
        ],
      ),
    );
  }

  valueChanger({required value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        valueDown(value: value),
        const SizedBox(
          width: 25,
        ),
        Obx(() => showValue(show: value)),
        const SizedBox(
          width: 25,
        ),
        valueUp(value: value),
      ],
    );
  }

  valueToggle(
      {required RxBool value,
      required String title,
      required double width,
      required double height}) {
    return GestureDetector(
        onTap: () {
          if (value.value == true) {
            value.value = false;
            ut.buttonColor.value = const Color.fromARGB(255, 237, 52, 52);
          } else {
            value.value = true;
            ut.buttonColor.value = const Color.fromARGB(255, 0, 101, 179);
          }
          print(value);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ut.buttonColor.value),
          width: width,
          height: height,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ));
  }

  d() {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 10.h,
          ),
          drawerWid(
              title: 'About',
              function: () => print('about'),
              icon: Obx(() => Icon(
                    Icons.info_outline,
                    color: ut.tt.value,
                    size: 35,
                  ))),

          drawerWid(
              title: 'Admin',
              function: () => Get.to(() => const AdminAuth()),
              icon: Obx(() => Icon(
                    Icons.person,
                    color: ut.tt.value,
                    size: 35,
                  ))),
          drawerWid(
              title: 'Change Theme',
              function: () => ut.toggleTheme(),
              icon: Obx(() => Icon(
                    Icons.dark_mode_outlined,
                    color: ut.tt.value,
                    size: 35,
                  ))),
          // This our way of sending all this data to the sheets. Simply match the value with the column of data.
          drawerWid(
              title: 'Manual',
              function: () async {
                final submitData = {
                  UserFields.teamName: 'Cyber Vipers',
                  UserFields.teamNum: 8717,
                  UserFields.leave: sv.leave.value,
                  UserFields.autoAmp: sv.autoAmp.value,
                  UserFields.autoSpeker: sv.autoSpeaker.value,
                  UserFields.teleopAmp: sv.teleopAmp.value,
                  UserFields.teleopSpeaker: sv.teleopSpeaker.value,
                  UserFields.onstage: sv.onstage.value,
                  UserFields.park: sv.park.value,
                  UserFields.trap: sv.trap.value,
                  UserFields.comments: sv.comments.value,
                };
                await GoogleSheetsApi.sendData([submitData]);
              },
              icon: Obx(() => Icon(
                    Icons.send,
                    color: ut.tt.value,
                    size: 35,
                  ))),
          drawerWid(
              title: 'Update?',
              function: () => print('update'),
              icon: Obx(() => Icon(
                    Icons.update,
                    color: ut.tt.value,
                    size: 35,
                  ))),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: const Text(
                  'Version 2.0',
                  style: TextStyle(color: Colors.grey, fontFamily: 'NotoSans'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ab({required String title}) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontSize: 25, fontFamily: 'NotoSans'),
      ),
    );
  }

  bnb() {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      iconSize: 28,
      elevation: 0,
      currentIndex: selectedIndex.value,
      onTap: (index) {
        selectedIndex.value = index;
        switch (index) {
          case 0:
            Get.off(() => const HomePage());
          case 1:
            Get.off(() => const ScoutPage());
          case 2:
            Get.off(() => const StatsPage());
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
            backgroundColor: Colors.transparent),
        BottomNavigationBarItem(
            icon: Icon(Icons.content_paste),
            label: 'Scout',
            backgroundColor: Colors.transparent),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Stats',
            backgroundColor: Colors.transparent),
      ],
    );
  }
}
