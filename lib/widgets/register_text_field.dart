import 'package:flutter/material.dart';

import 'component.dart';
import 'edit_text_field.dart';

class RegisterTextField extends StatelessWidget {

  final IconData icon;
  final TextEditingController? controller;
  final String lableText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final bool? obscureText;
  final Function? onPressed;

  const RegisterTextField({
    super.key,
    required this.icon,
    this.controller,
    required this.lableText,
    required this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.obscureText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        defContainerWithIcon(
          icon: icon,
        ),
        Expanded(
          child: EditTextField(
            lableText: lableText,
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            suffixIcon: suffixIcon,
            obscureText: obscureText != null ? obscureText! : false,
            onPressed: (){
              onPressed!();
            },
          ),
        ),
      ],
    );
  }
}
