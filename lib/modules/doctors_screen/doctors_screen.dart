import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_manage_app/modules/doctors_screen/widgets/custom_doctor_item.dart';

import '../../core/api/services/local/cache_helper.dart';
import '../../core/styles/colors/colors.dart';
import '../../core/widgets/custome_error_widget.dart';
import '../../core/widgets/custome_progress_indicator.dart';
import '../register_doctor_screen/register_doctor_screen.dart';
import 'manager/doctors_cubit.dart';
import 'manager/doctors_states.dart';

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
            InkWell(
              onTap: () {},
              child: const Icon(Icons.logout, size: 25),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: DoctorsViewBody(token: token),
        floatingActionButton: FloatingActionButton(
          heroTag: 'heroTag1',
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
          return _Body(
            state: state,
            doctorCubit: BlocProvider.of<DoctorCubit>(context),
          );
        } else {
          return const CustomeProgressIndicator();
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  final DoctorCubit doctorCubit;
  final DoctorsSuccess state;
  const _Body({
    required this.state,
    required this.doctorCubit,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return doctorCubit.getDoctors(token: CacheHelper.getData(key: 'Token'));
      },
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 260.h,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 5.w,
              mainAxisSpacing: 5.h,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CustomDoctorItem(
                  doctorModel: state.doctors[index],
                );
              },
              childCount: state.doctors.length,
            ),
          ),
        ],
      ),
    );
  }
}
