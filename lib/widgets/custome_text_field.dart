import 'package:flutter/material.dart';

import '../styles/colors/colors.dart';
import 'custome_icon.dart';

class CustomeTextField extends StatelessWidget {
  final String? hintText;
  final IconData? iconData;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  const CustomeTextField({
    super.key,
    this.hintText,
    this.iconData,
    this.onChanged,
    this.keyboardType,
    this.obscureText,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomeIcon(icon: iconData ?? Icons.email),
        const SizedBox(width: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: TextFormField(
            validator: validator ??
                (value) {
                  if (value?.isEmpty ?? true) {
                    return 'required ...';
                  }
                  return null;
                },
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            onChanged: onChanged,
            cursorColor: defaultColor,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon,
              focusedBorder: getBorder(),
            ),
          ),
        ),
      ],
    );
  }

  UnderlineInputBorder getBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: defaultColor,
      ),
    );
  }
}
