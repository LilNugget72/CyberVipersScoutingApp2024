import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:cyberviperscoutingapp2024/controllers/sheet_values.dart';
import 'package:cyberviperscoutingapp2024/controllers/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.put(ReuseWid());
    UserTheme ut = Get.put(UserTheme());
    SheetValues sv = Get.find();
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: rw.ab(title: 'Home Page'),
      drawer: rw.d(),
      body: Column(
        children: [
          rw.line(),
          if (!isKeyboard)
            Padding(
              padding: EdgeInsets.only(top: 25.h),
              child: Image(
                height: 530.h,
                image: const AssetImage('lib/assets/Sponsor_image.png'),
              ),
            ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 300.w,
                child: Obx(
                  () => TextField(
                    autocorrect: false,
                    controller: sv.scoutName,
                    textAlign: TextAlign.center,
                    enabled: true,
                    cursorColor: ut.tt.value,
                    style: TextStyle(
                        color: ut.tt.value,
                        fontFamily: 'NotoSans',
                        fontSize: 20),
                    decoration: InputDecoration(
                      label: Center(
                          child: Text(
                        'First Name and Team Number',
                        style: TextStyle(
                            color: ut.ts.value,
                            fontFamily: 'NotoSans',
                            fontSize: 20),
                      )),
                      labelStyle: TextStyle(color: ut.tt.value),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: ut.tt.value)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: BorderSide(color: ut.tt.value, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: BorderSide(color: ut.tt.value, width: 2)),
                    ),
                  ),
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
