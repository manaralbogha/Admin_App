import 'package:flutter/material.dart';

import '../styles/colors/colors.dart';
import 'component.dart';

class DefaultTextInfo extends StatelessWidget {
  final String caption;
  final String text;
  //final Color? color;
  final IconData icon;
  //final Color? iconColor;
  //final double? iconSize;

  const DefaultTextInfo({
    super.key,
    required this.caption,
    required this.text,
    //this.color,
    required this.icon,
    //this.iconColor,
    //this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        defContainerWithIcon(
          icon: icon,
        ),
        Padding(
           padding: const EdgeInsetsDirectional.only(
             start: 14.0,
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                caption,
                style: const TextStyle(
                  color: color5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
        ),
         ),
      ],
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:project_1_app/colors.dart';

class DefaultTextField extends StatelessWidget {
  final String text;
  final String? discribtionText;
  final double? fieldWidth;
  final double? fieldHeight;
  final IconData? icon;

  const DefaultTextField({
    super.key,
    required this.text,
    this.discribtionText,
    this.fieldWidth,
    this.fieldHeight,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
              start: 25.0,
              bottom: 1.0
          ),
          child: Text(
            discribtionText!,
            style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Material(
          color: defaultColor,
          elevation: 10.0,
          borderRadius: BorderRadiusDirectional.circular(30.0),
          shadowColor: Colors.grey[100],
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              //border: BoxBorder(BorderSide.none),
            ),
            height: fieldHeight,
            width: fieldWidth,
            padding: const EdgeInsetsDirectional.only(
                start: 25.0,
                end: 10.0,
                top: 5.0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Icon(
                  icon,
                  size: 30.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .03,
                ),*/
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

 */