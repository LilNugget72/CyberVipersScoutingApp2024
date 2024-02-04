import 'package:cyberviperscoutingapp2024/admin_hub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/reuseable_widgets.dart';
import 'controllers/user_theme.dart';

class AdminAuth extends StatelessWidget {
  const AdminAuth({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();
    UserTheme ut = Get.find();
    return Scaffold(
      appBar: rw.ab(title: 'Admin Authentication'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ut.tt.value)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ut.tt.value),
              ),
            ),
            style: TextStyle(color: ut.tt.value),
            onSubmitted: (value) {
              if (value == '8717') {
                Get.to(() => const AdminHub());
              } else {
                showDialog(
                  context: context,
                  builder: (context) => const Dialog(
                    insetPadding: EdgeInsets.fromLTRB(100, 310, 100, 310),
                    backgroundColor: Colors.red,
                    child: Center(
                      child: Text(
                        'TRY AGAIN \nBOZO',
                        style: TextStyle(
                            fontFamily: 'SenorSaturno',
                            fontSize: 40,
                            color: Colors.white),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
