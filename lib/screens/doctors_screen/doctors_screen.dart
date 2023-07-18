import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_admin_app/core/api/services/local/cache_helper.dart';
import 'package:project_one_admin_app/core/models/doctor_model.dart';
import 'package:project_one_admin_app/core/styles/colors/colors.dart';
import 'package:project_one_admin_app/core/widgets/custome_error_widget.dart';
import 'package:project_one_admin_app/core/widgets/custome_progress_indicator.dart';
import 'package:project_one_admin_app/screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:project_one_admin_app/screens/doctors_screen/manager/doctors_cubit.dart';
import 'package:project_one_admin_app/screens/doctors_screen/manager/doctors_states.dart';
import 'package:project_one_admin_app/screens/login_screen/login_screen.dart';
import 'package:project_one_admin_app/screens/register_doctor_screen/register_doctor_screen.dart';

import '../../core/widgets/custome_list_view_item.dart';

class DoctorsView extends StatelessWidget {
  static const route = 'DoctorsView';
  final String token;
  const DoctorsView({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorCubit()..getDoctors(token: token),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Doctors'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  CacheHelper.deletData(key: 'Token');
                  Navigator.popAndPushNamed(context, LoginView.route);
                },
                child: const Text('LOGOUT'))
          ],
        ),
        body: DoctorsViewBody(token: token),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              RegisterDoctorView.route,
              arguments: token,
            );
          },
          backgroundColor: defaultColor,
          child: const Icon(Icons.add, size: 40),
        ),
      ),
    );
  }
}

class DoctorsViewBody extends StatelessWidget {
  final String token;
  const DoctorsViewBody({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorsStates>(
      builder: (context, state) {
        if (state is DoctorsFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is DoctorsSuccess) {
          return _body(context, doctors: state.doctors, token: token);
        } else {
          return const CustomeProgressIndicator();
        }
      },
    );
  }

  Widget _body(context,
      {required List<DoctorModel> doctors, required String token}) {
    DoctorCubit doctorCubit = BlocProvider.of<DoctorCubit>(context);
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => CustomeListViewItem(
        doctorModel: doctors[index],
        onPressed: () {
          Navigator.pushNamed(
            context,
            DoctorDetailsView.route,
            arguments: doctors[index],
          );
        },
        iconOnPressed: () {
          doctorCubit.deleteDoctor(context,
              token: token, userID: doctors[index].userID);
        },
      ),
      separatorBuilder: (context, index) => const Divider(
        height: 20,
        indent: 25,
        endIndent: 25,
      ),
      itemCount: doctors.length,
    );
  }
}
