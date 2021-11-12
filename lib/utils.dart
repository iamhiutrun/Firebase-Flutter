import 'package:flutter/material.dart';

class Utils {
  static bool isEmailValid(TextEditingController controller) {
    final email = controller.text.trim().toString();
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool isPasswordValid(TextEditingController controller) {
    return controller.text.trim().toString().length > 8;
  }

}
