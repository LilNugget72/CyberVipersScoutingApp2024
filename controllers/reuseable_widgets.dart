import 'package:cyberviperscoutingapp2024/admin_auth.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:cyberviperscoutingapp2024/read_sheet.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/main_scout_page.dart';
import 'package:cyberviperscoutingapp2024/scouting_pages/manual_function.dart';
import 'package:cyberviperscoutingapp2024/stats_page/stats_page.dart';
import 'package:cyberviperscoutingapp2024/stats_page/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReuseWid extends GetxController {
  RxInt selectedIndex = 0.obs;
  UserTheme ut = Get.find();
  SheetValues sv = Get.put(SheetValues());
  TextEditingController event = TextEditingController();

  textForGraph({required String name}) {
    return Text(
      name,
      style: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: 18,
          color: ut.tt.value,
          letterSpacing: 1.6),
    );
  }

  line() {
    return Container(
      height: 1.5,
      color: ut.tt.value,
    );
  }

  teaminfo() {
    sv.teamName.value = sv.eventTeams[sv.teamNum.value]!;

    return Center(
      child: Text(
        '${sv.teamNum.value} - ${sv.teamName.value}',
        style:
            TextStyle(fontFamily: 'NotoSans', color: ut.tt.value, fontSize: 20),
      ),
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

  valueToggle(
      {required RxBool value,
      required String title,
      required double width,
      required double height,
      required Rx<Color> fillColor,
      required Color textColor}) {
    return InkWell(
      splashFactory: InkSplash.splashFactory,
      splashColor: Colors.grey[300],
      borderRadius: BorderRadius.circular(18.r),
      onTap: () {
        if (value.value == true) {
          value.value = false;
          fillColor.value = Colors.transparent;
          textColor = ut.tt.value;
        } else {
          value.value = true;
          fillColor.value = ut.buttonColor.value;
          textColor = Colors.white;
        }
        print(textColor);
      },
      child: Obx(
        () => Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: ut.buttonColor.value, width: 4.w),
              color: fillColor.value),
          width: width,
          height: height,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: textColor, fontSize: 30, fontFamily: 'NotoSans'),
            ),
          ),
        ),
      ),
    );
  }

  d() {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
              title: 'Manual',
              function: () {
                Get.to(() => const ManualPage());
              },
              icon: Obx(() => Icon(
                    Icons.add_circle_outline_rounded,
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
          Padding(
              padding: EdgeInsets.only(left: 35.w, top: 20.h),
              child: Obx(
                () => SizedBox(
                  height: 50.h,
                  child: DropdownMenu(
                    trailingIcon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.white,
                    ),
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSans',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                    onSelected: (value) async {
                      sv.eventKey.value = sv.regionalEvents[value];
                      sv.eventTeams.value = await eventTeams();
                      sv.teamListHint.value = 'Select a Team';
                    },
                    inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.r),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2))),
                    menuStyle: MenuStyle(
                        minimumSize:
                            MaterialStatePropertyAll(Size(100.w, 10.h)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    width: 200.w,
                    controller: event,
                    leadingIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    dropdownMenuEntries:
                        sv.regionalEventsKeys.map<DropdownMenuEntry<dynamic>>(
                      (dynamic value) {
                        return DropdownMenuEntry(
                          value: value,
                          label: value,
                          labelWidget: Text(
                            value,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'NotoSans',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              )),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: const Text(
                  'Version 1.0',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'NotoSans',
                  ),
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
      onTap: (index) async {
        selectedIndex.value = index;
        switch (index) {
          case 0:
            Get.off(() => const HomePage());
          case 1:
            Get.off(() => const ScoutPage());
          case 2:
            var thing = await eventTeams();
            var sortTeamList = thing.keys.toList();
            sortTeamList.sort();
            sv.teamXList.value = sortTeamList;
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
