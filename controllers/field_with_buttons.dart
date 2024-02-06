import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TouchField extends GetxController {
  redSide() {
    return Stack(
      children: [
        const Image(
          height: 400,
          image: AssetImage('lib/assets/2160xDarkCroppedFixed - Red.png'),
        ),
      ],
    );
  }

  button() {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60), color: Colors.yellow),
    );
  }
}
