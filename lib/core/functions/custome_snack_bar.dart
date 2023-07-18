import 'package:flutter/material.dart';
import 'package:project_one_admin_app/core/styles/colors/colors.dart';

abstract class CustomeSnackBar {
  static void showSnackBar(BuildContext context,
      {required String msg, Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(milliseconds: 4000),
        content: Text(
          msg,
          textAlign: TextAlign.center,
        ),
        backgroundColor: defaultColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
