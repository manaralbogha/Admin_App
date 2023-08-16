import 'package:flutter/material.dart';
import '../styles/colors/colors.dart';
import '../styles/text_styles.dart';

class CustomeTextInfo extends StatelessWidget {
  final String text;
  final IconData iconData;
  const CustomeTextInfo(
      {super.key, required this.text, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // CustomeIcon(icon: iconData),
        Icon(
          iconData,
          color: defaultColor2,
          size: 30,
        ),
        const SizedBox(width: 5),
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          // width: 175.w,
          child: Text(
            text,
            style: TextStyles.textStyle16.copyWith(color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
