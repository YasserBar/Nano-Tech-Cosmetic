import 'package:flutter/material.dart';

abstract class AppColors {
  // Figma Colors
  static const Color primarySolid = Color(0xFFAC3A99);
  static const Color primary = Color(0xB3AC3A99);
  static const Color primary1 = Color(0xFFEA49D0);
  static const Color primary2 = Color(0xFFFEC6F5);
  static const Color secondary = Color(0xFF0977F5);
  static const Color secondary1 = Color(0xB34898F3);
  static const Color secondary2 = Color(0xFFC1DCFB);
  static const Color gray = Color(0xFF727171);

  // Normal Colors
  static const Color black = Colors.black;
  static const Color black60 = Colors.black54;

  static const Color white = Color(0xFFFFFFFF);
  static const Color white1 = Color(0xFFE9E6E6);
  static const Color white50 = Colors.white54;

  static const Color transparent = Colors.transparent;
  static const Color amber = Colors.amber;

  // Primary Colors
  static const MaterialColor materialPrimary = MaterialColor(0xFFAC3A99, {
    50: Color(0xFFFBEFF5),
    100: Color(0xFFFCDBEE),
    200: Color(0xFFF6B5D9),
    300: Color(0xFFE68AC5),
    400: Color(0xFFCD67B2),
    500: Color(0xFFAC3A99),
    600: Color(0xFF932A8C),
    700: Color(0xFF791D7B),
    800: Color(0xFF5A1263),
    900: Color(0xFF430B52),
  });

  static const Color danger1 = Color(0xFFEC7653);
  static const Color danger2 = Color(0xFFE03C1F);
  static const Color danger3 = Color(0xFFC02216);

  static const Color warning1 = Color(0xFFEDD53B);
  static const Color warning2 = Color(0xFFE2C000);
  static const Color warning3 = Color(0xFFC2A200);

  static const Color success1 = Color(0xFF5EFB58);
  static const Color success2 = Color(0xFF14AA50);
  static const Color success3 = Color(0xFF0E9250);

  static const Color info1 = Color(0xFF7CB1FF);
  static const Color info2 = Color(0xFF1153BF);
  static const Color info3 = Color(0xFF0C40A4);
}
