import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_one_admin_app/core/styles/text_styles.dart';
import '../styles/colors/colors.dart';

class CustomeTextInfo extends StatelessWidget {
  final String text;
  final IconData iconData;
  const CustomeTextInfo(
      {super.key, required this.text, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: defaultColor,
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 175.w,
          child: Text(
            text,
            style: TextStyles.textStyle16,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
