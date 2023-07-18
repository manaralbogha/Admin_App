import 'package:flutter/material.dart';
import 'package:project_one_admin_app/core/styles/colors/colors.dart';

abstract class TextStyles {
  static const TextStyle textStyle16 =
      TextStyle(color: defaultColor, fontSize: 16, letterSpacing: .6);

  static const TextStyle textStyle18 =
      TextStyle(color: Colors.grey, fontSize: 18, letterSpacing: .8);

  static const TextStyle textStyle20 =
      TextStyle(color: defaultColor, fontSize: 20);

  static const TextStyle textStyle25 =
      TextStyle(color: defaultColor, fontSize: 25);

  static const TextStyle textStyle30 =
      TextStyle(color: defaultColor, fontSize: 30);

  static const TextStyle textStyle50 =
      TextStyle(color: defaultColor, fontSize: 50);
}
