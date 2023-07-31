import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDimensions {
  static final double bodyHeightWithNav =
      (Get.height - kBottomNavigationBarHeight - (Get.height * 0.09));
  static final double bodyHeightWithoutNav = (Get.height - (Get.height * 0.09));

  static const double sidesBodyPadding = 15;
  static const double appbarBodyPadding = 20;
}
