import 'package:flutter/material.dart';

class AppColor {
  static const backgroundColor = Colors.white;
  static const txtPrimaryColor = Color(0xff042C5C);
  static const txtHintColor = Color(0xFFA5A7A9);

  static const tfBackgroundColor = Color(0xFFf5f6f8);

  // Gradient colors
  static const btnRegisterGradient = LinearGradient(
    colors: [Color(0xff6F86D6), Color(0xff48C6EF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const btnDisableGradient = LinearGradient(
    colors: [Colors.grey, Colors.grey],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
