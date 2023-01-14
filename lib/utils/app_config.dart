// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStyles {
  static Color bgPrimary = Color(0xFF1152FD);
  static Color bgOrange = Color(0xFFe36414);
  static Color bgGreen = Color(0xFF2d6a4f);
  static Color bgGreenLight = Color.fromARGB(255, 59, 134, 100);
  static Color bgBlue = Color.fromARGB(255, 5, 93, 122);
  static Color bgBlueLight = Color.fromARGB(255, 12, 134, 174);
}

class AppLayout {
  static getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static getScreenHeight() {
    return Get.height;
  }

  static getScreenWidth() {
    return Get.width;
  }

  static getHeight(double pixels) {
    double x = getScreenHeight() / pixels;

    return getScreenHeight() / x;
  }

  static getWidth(double pixels) {
    double x = getScreenWidth() / pixels;

    return getScreenWidth() / x;
  }
}

extension PercentSized on double {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
}

extension ResponsiveText on double {
  double get sp => Get.width / 100 * (this / 3);
}
