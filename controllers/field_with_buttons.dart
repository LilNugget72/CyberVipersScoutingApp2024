import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TouchField extends GetxController {
  Color filling = Colors.blue;
  RxBool pickedNote = false.obs;
  /* quick side note
   I came across an issue where I couldn't use the button class inside the Stack 
   when I made it an ink widget from a container 
   The solution i found for this was to make the image an ink and that fixed it
   if this happens with something outside an image try to make it use ink or inkwell */
  redSide() {
    return Stack(
      children: [
        Ink.image(
          height: 410,
          image: const AssetImage('lib/assets/2160xDarkCroppedFixed - Red.png'),
        ),
        button(),
      ],
    );
  }

  toggleFilling() {
    if (pickedNote.value == false) {
      pickedNote.value = true;
      filling = Colors.blue;
    } else {
      pickedNote.value = false;
      filling = Colors.transparent;
    }
  }

  button() {
    return InkWell(
      splashColor: Colors.brown,
      borderRadius: BorderRadius.circular(60),
      onTap: () {
        toggleFilling();
        print(filling);
      },
      child: Ink(
        width: 23,
        height: 23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          border: Border.all(color: Colors.blue),
          color: Colors.black,
        ),
      ),
    );
  }
}
