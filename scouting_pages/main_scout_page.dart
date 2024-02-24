import 'package:cyberviperscoutingapp2024/controllers/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoutPage extends StatelessWidget {
  const ScoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    ReuseWid rw = Get.find();

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
                onTap: () async {},
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
