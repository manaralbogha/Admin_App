import 'package:flutter/material.dart';

import '../models/secretaria/view_secretaria_model.dart';
import 'custome_image.dart';
import 'default_text_info.dart';

class SecretariaProfileItem extends StatelessWidget {

  final ViewSecretariaModel? model;

  const SecretariaProfileItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomeImage(
          image: 'assets/images/undraw_Male_avatar_g98d (1).png',
          width: MediaQuery.of(context).size.height * .2,
          height: MediaQuery.of(context).size.height * .2,
          borderRadius: BorderRadius.circular(40),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        DefaultTextInfo(
          caption: 'First Name',
          text: model!.secretary!.user.firstName,
          icon: Icons.person,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        DefaultTextInfo(
          caption: 'Last Name',
          text: model!.secretary!.user.lastName,
          icon: Icons.person,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        DefaultTextInfo(
          caption: 'Phone Number',
          text: model!.secretary!.user.phoneNum,
          icon: Icons.call,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        DefaultTextInfo(
          caption: 'Email',
          text: model!.secretary!.user.email,
          icon: Icons.email,
        ),
      ],
    );
  }
}
