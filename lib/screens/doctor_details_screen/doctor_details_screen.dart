import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_admin_app/core/models/doctor_model.dart';
import 'package:project_one_admin_app/core/widgets/custome_icon.dart';
import 'package:project_one_admin_app/core/widgets/custome_text_field.dart';
import 'package:project_one_admin_app/main.dart';
import 'package:project_one_admin_app/screens/doctor_details_screen/manager/doctor_details_cubit.dart';
import 'package:project_one_admin_app/screens/doctor_details_screen/manager/doctor_details_states.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/styles/text_styles.dart';
import '../../core/utils/app_assets.dart';

class DoctorDetailsView extends StatelessWidget {
  static const route = 'DoctorDetailsView';
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    DoctorModel doctorModel =
        ModalRoute.of(context)!.settings.arguments as DoctorModel;
    return BlocProvider(
      create: (context) => DoctorDetailsCubit(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                launchUrl(Uri.parse("tel://${doctorModel.user.phoneNum}"));
              },
              icon: const Icon(
                Icons.phone,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ],
          title: Text('Dr. ${doctorModel.user.firstName} Details'),
        ),
        body: DoctorDetailsViewBody(doctorModel: doctorModel),
      ),
    );
  }
}

class DoctorDetailsViewBody extends StatelessWidget {
  final DoctorModel doctorModel;
  const DoctorDetailsViewBody({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorDetailsCubit, DoctorDetailsStates>(
      builder: (context, state) {
        return _body(context, doctorModel: doctorModel);
      },
    );
  }

  Widget _body(context, {required DoctorModel doctorModel}) {
    DoctorDetailsCubit cubit = BlocProvider.of<DoctorDetailsCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: screenSize.height * .02),
          CircleAvatar(
            backgroundImage: const AssetImage(AppAssets.defaultImage),
            radius: screenSize.width * .2,
          ),
          const SizedBox(height: 20),
          cubit.edit
              ? const CustomeTextField()
              : CustomeDetailsItem(
                  icon: Icons.person,
                  text:
                      'Dr. ${doctorModel.user.firstName} ${doctorModel.user.lastName}',
                ),
          const SizedBox(height: 10),
          CustomeDetailsItem(
            icon: FontAwesomeIcons.stethoscope,
            text: doctorModel.specialty,
          ),
          const SizedBox(height: 10),
          CustomeDetailsItem(
            icon: Icons.email,
            text: doctorModel.user.email,
          ),
          const SizedBox(height: 10),
          CustomeDetailsItem(
            icon: Icons.phone,
            text: doctorModel.user.phoneNum,
          ),
        ],
      ),
    );
  }
}

class CustomeDetailsItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const CustomeDetailsItem({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomeIcon(
          icon: icon,
          size: 50,
        ),
        const SizedBox(width: 20),
        Text(
          text,
          style: TextStyles.textStyle25,
          maxLines: 1,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
