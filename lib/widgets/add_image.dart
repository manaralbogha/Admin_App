import 'package:flutter/material.dart';

class AddImage extends StatelessWidget {
  final String image;
  final double? height, width;
  final BorderRadiusGeometry? borderRadius;
  const AddImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Container(
          height: height ?? MediaQuery.of(context).size.height * .25,
          width: width ?? MediaQuery.of(context).size.width * .25,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image),
            ),
          ),
        ),
      ]
    );
  }
}
