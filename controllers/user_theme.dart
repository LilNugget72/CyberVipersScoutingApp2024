import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTheme extends GetxController {
  final RxBool userThemeState = true.obs;

  final Rx<Color> tt = Colors.white.obs;
  final Rx<Color> ts = Color.fromARGB(85, 255, 255, 255).obs;

  Rx<Color> buttonColor = const Color.fromARGB(255, 237, 52, 52).obs;
  // Color.fromARGB(255, 237, 52, 52).obs is red
  //Color.fromARGB(255, 0, 101, 179).obs is blue

  Rx<ThemeData> currentTheme = ThemeData(
    canvasColor: Colors.grey,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontFamily: 'NotoSans'),
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    drawerTheme: DrawerThemeData(
        backgroundColor: Colors.grey[850], shadowColor: Colors.grey[850]),
  )
      .copyWith(
          scaffoldBackgroundColor: Colors.grey[850],
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedLabelStyle: TextStyle(
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.bold,
                fontSize: 18),
            unselectedLabelStyle:
                TextStyle(fontFamily: 'NotoSans', fontSize: 16),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
          ),
          textSelectionTheme: const TextSelectionThemeData(
              selectionColor: Colors.blue, selectionHandleColor: Colors.blue))
      .obs;
  Color? bars = Colors.grey[850];
  Brightness statbright = Brightness.light;

  // final ThemeData lightTheme = ThemeData(
  //   splashColor: Colors.transparent,
  //   highlightColor: Colors.transparent,
  //   appBarTheme: const AppBarTheme(
  //     elevation: 0,
  //     backgroundColor: Colors.transparent,
  //     iconTheme: IconThemeData(color: Colors.black),
  //   ),
  //   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //     backgroundColor: Colors.white,
  //     elevation: 0,
  //     selectedItemColor: Colors.black,
  //     unselectedItemColor: Colors.black,
  //   ),
  //   drawerTheme: const DrawerThemeData(
  //       backgroundColor: Colors.white, shadowColor: Colors.white),
  // ).copyWith(
  //     scaffoldBackgroundColor: Colors.white,
  //     textTheme: const TextTheme().apply(),
  //     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //         selectedLabelStyle: TextStyle(
  //             fontFamily: 'NotoSans',
  //             fontWeight: FontWeight.bold,
  //             fontSize: 18),
  //         unselectedLabelStyle: TextStyle(fontFamily: 'NotoSans', fontSize: 16),
  //         selectedItemColor: Colors.black,
  //         unselectedItemColor: Colors.black),
  //     textSelectionTheme: const TextSelectionThemeData(
  //         selectionColor: Colors.blue, selectionHandleColor: Colors.blue));

  // final ThemeData darkTheme = ThemeData(
  //   splashColor: Colors.transparent,
  //   highlightColor: Colors.transparent,
  //   appBarTheme: const AppBarTheme(
  //     elevation: 0,
  //     titleTextStyle: TextStyle(color: Colors.white),
  //     backgroundColor: Colors.transparent,
  //     iconTheme: IconThemeData(color: Colors.white),
  //   ),
  //   drawerTheme: DrawerThemeData(
  //       backgroundColor: Colors.grey[850], shadowColor: Colors.grey[850]),
  // ).copyWith(
  //     scaffoldBackgroundColor: Colors.grey[850],
  //     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //       selectedLabelStyle: TextStyle(
  //           fontFamily: 'NotoSans', fontWeight: FontWeight.bold, fontSize: 18),
  //       unselectedLabelStyle: TextStyle(fontFamily: 'NotoSans', fontSize: 16),
  //       selectedItemColor: Colors.white,
  //       unselectedItemColor: Colors.white,
  //     ),
  //     textSelectionTheme: const TextSelectionThemeData(
  //         selectionColor: Colors.blue, selectionHandleColor: Colors.blue));

  // borderThemes() {
  //   if (userThemeState.value == true) {
  //     bars = Colors.grey[850];
  //     statbright = Brightness.light;
  //   } else {
  //     bars = Colors.white;
  //     statbright = Brightness.dark;
  //   }
  // }

  // toggleTheme() {
  //   if (userThemeState.value == true) {
  //     userThemeState.value = false;
  //     currentTheme.value = lightTheme;
  //     tt.value = Colors.black;
  //     ts.value = Colors.grey;
  //   } else {
  //     userThemeState.value = true;
  //     currentTheme.value = darkTheme;
  //     tt.value = Colors.white;
  //     ts.value = const Color.fromARGB(85, 255, 255, 255);
  //     borderThemes();
  //   }
  // }
}
