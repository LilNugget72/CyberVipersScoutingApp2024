import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:cyberviperscoutingapp2024/home_page.dart';
import 'package:cyberviperscoutingapp2024/stats_page/read_sheet.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.put(ReuseWid());
    SheetValues sv = Get.find();
    UserTheme ut = Get.find();

    Rx<Color> noEvent = Colors.white.obs;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'NotoSans',
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          rw.nameField(),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: SizedBox(
                width: 110.w,
                child: Obx(
                  () => TextField(
                    maxLength: 4,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    textInputAction: TextInputAction.done,
                    autocorrect: false,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    controller: sv.scoutersTeam,
                    textAlign: TextAlign.center,
                    enabled: true,
                    cursorColor: Colors.white,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSans',
                        fontSize: 20),
                    decoration: InputDecoration(
                      counterText: '',
                      label: Center(
                        child: Text(
                          'Team #',
                          style: TextStyle(
                              color: ut.ts.value,
                              fontFamily: 'NotoSans',
                              fontSize: 20),
                        ),
                      ),
                      labelStyle: const TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide:
                              BorderSide(color: ut.tfc.value, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide:
                              BorderSide(color: ut.tfc.value, width: 2)),
                    ),
                  ),
                ),
              )),
          rw.toggleEventType(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Center(
              child: Obx(
                () => DropdownButton2(
                  underline: const SizedBox(),
                  hint: Obx(
                    () => Text(
                      '    ${sv.eventListHint}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSans',
                        fontSize: 17,
                      ),
                    ),
                  ),
                  onChanged: (value) async {
                    sv.eventListHint.value = value!;
                    if (sv.isDistrict.isFalse) {
                      sv.eventKey.value = sv.regionalEvents[value];
                    } else {
                      sv.eventKey.value = sv.districtEvents[value];
                    }
                    noEvent.value = Colors.white;
                    sv.selectedAnEvent.value = true;

                    var blueMatches = await blueAllianceTeams();
                    var sortedBlue = blueMatches.keys.toList();
                    sortedBlue.sort();
                    sv.blueAllianceMatchesKeys.value = sortedBlue;
                    sv.blueAllianceMatches.value = blueMatches;

                    var redMatches = await redAllianceTeams();
                    var sortedRed = redMatches.keys.toList();
                    sortedRed.sort();
                    sv.redAllianceMatchesKeys.value = sortedRed;
                    sv.redAllianceMatches.value = redMatches;

                    var thing = await eventTeams();
                    var sortTeamList = thing.keys.toList();
                    sortTeamList.sort();
                    sv.teamXList.value = sortTeamList;
                    sv.eventTeams.value = thing;

                    sv.teamListHint.value = 'Select A Team To View';
                  },
                  items: sv.events
                      .map((dynamic event) => DropdownMenuItem<String>(
                            value: event,
                            child: Text(
                              event,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'NotoSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                          ))
                      .toList(),
                  alignment: Alignment.center,
                  iconStyleData:
                      const IconStyleData(iconEnabledColor: Colors.white),
                  dropdownStyleData: DropdownStyleData(
                    scrollbarTheme: const ScrollbarThemeData(
                        thumbColor: MaterialStatePropertyAll(Colors.grey)),
                    maxHeight: 350.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r)),
                  ),
                  buttonStyleData: ButtonStyleData(
                    width: 230.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: noEvent.value, width: 2),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
          rw.statsType(),
          const Expanded(child: SizedBox()),
          if (!isKeyboard)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: GestureDetector(
                  onTap: () {
                    if (sv.scoutName.text.isEmpty ||
                        sv.scoutersTeam.text.isEmpty ||
                        sv.selectedAnEvent.isFalse) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          showCloseIcon: true,
                          backgroundColor: Colors.grey[800],
                          content: const Text(
                            'Fill in All Values',
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      );
                    } else {
                      sv.pref.write('scouters name', sv.scoutName.text);
                      sv.pref.write('scouters team', sv.scoutersTeam.text);
                      sv.pref.write('event key', sv.eventKey.value);
                      sv.pref
                          .write('selected event name', sv.eventListHint.value);
                      sv.pref
                          .write('selected event?', sv.selectedAnEvent.value);
                      sv.pref
                          .write('team only data', sv.wantsTeamOnlyStats.value);

                      sv.pref.write('booted', true);
                      Get.off(() => const HomePage());
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 13.w),
                      child: const Text(
                        'LETS GET SCOUTING',
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'NotoSans',
                            color: Colors.white),
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
