import 'package:flutter/material.dart';

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
          width: MediaQuery.of(context).size.width * .55,
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
