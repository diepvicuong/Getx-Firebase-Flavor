import 'package:flutter/material.dart';

class ScreenUtils {
  static double resizeHeightUtil(BuildContext context, double value) {
    var screenWidth = MediaQuery.of(context).size.height;
    var screenDesignHeight = 812;
    return (screenWidth * value) / screenDesignHeight;
  }

  static double resizeWidthUtil(BuildContext context, double value) {
    var screenHeight = MediaQuery.of(context).size.width;
    var screenDesignWidth = 375;
    return (screenHeight * value) / screenDesignWidth;
  }
}
