import 'package:flutter/material.dart';
import '../models/patient/view_patient_model.dart';

import 'custome_image.dart';
import 'default_text_info.dart';

class PatientProfileItem extends StatelessWidget {

  final ViewPatientModel? model;
  var formKey = GlobalKey<FormState>();

  PatientProfileItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomeImage(
            image: 'assets/images/undraw_Female_avatar_efig (1).png',
            width: MediaQuery.of(context).size.height * .2,
            height: MediaQuery.of(context).size.height * .2,
            borderRadius: BorderRadius.circular(40),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          DefaultTextInfo(
            caption: 'First Name',
            text: model!.patient.user.firstName,
            icon: Icons.person,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          DefaultTextInfo(
            caption: 'Last Name',
            text: model!.patient.user.lastName,
            icon: Icons.person,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          DefaultTextInfo(
            caption: 'Phone Number',
            text: model!.patient.user.phoneNum,
            icon: Icons.call,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          DefaultTextInfo(
            caption: 'Email',
            text: model!.patient.user.email,
            icon: Icons.email,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          DefaultTextInfo(
            caption: 'Address',
            text: model!.patient.address,
            icon: Icons.location_on,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          DefaultTextInfo(
            caption: 'Birth Date',
            text: model!.patient.birthDate,
            icon: Icons.cake,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          DefaultTextInfo(
            caption: 'Gender',
            text: model!.patient.gender,
            icon: Icons.female,
          ),
        ],
      ),
    );
  }
}