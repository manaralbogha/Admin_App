import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_manage_app/modules/doctor_details_screen/widgets/doctor_details_button.dart';
import 'package:med_manage_app/modules/doctor_details_screen/widgets/edit_doctor_info_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/api/services/local/cache_helper.dart';
import '../../core/functions/custome_snack_bar.dart';
import '../../core/models/doctor_model.dart';
import '../../core/styles/colors/colors.dart';
import '../../core/widgets/custome_image.dart';
import '../../core/widgets/custome_progress_indicator.dart';
import '../../core/widgets/custome_text_info.dart';
import '../doctors_screen/doctors_screen.dart';
import '../register_doctor_screen/add_work_times_screen.dart';
import 'manager/doctor_details_cubit.dart';
import 'manager/doctor_details_states.dart';

class DoctorDetailsView extends StatelessWidget {
  static const route = 'DoctorDetailsView';
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    DoctorModel doctorModel =
        ModalRoute.of(context)!.settings.arguments as DoctorModel;
    return BlocProvider(
      create: (context) => DoctorDetailsCubit()
        ..storeDoctorWorkDays(doctorID: doctorModel.id)
        ..getDoctorDepartment(departmentID: doctorModel.departmentID),
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
          ],
          title: Text('Dr. ${doctorModel.user.firstName}'),
        ),
        body: DoctorDetailsViewBody(doctorModel: doctorModel),
        floatingActionButton:
            BlocBuilder<DoctorDetailsCubit, DoctorDetailsStates>(
          builder: (context, state) {
            return FloatingActionButton(
              heroTag: 'heroTag2',
              backgroundColor: defaultColor,
              onPressed: () {
                EditDoctorInfoBottomSheet.editDoctorInfoBottomSheet(
                  context,
                  doctorModel: doctorModel,
                  cubit: BlocProvider.of<DoctorDetailsCubit>(context),
                );
              },
              child: const Icon(Icons.edit),
            );
          },
        ),
      ),
    );
  }
}

class DoctorDetailsViewBody extends StatelessWidget {
  final DoctorModel doctorModel;
  const DoctorDetailsViewBody({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorDetailsCubit, DoctorDetailsStates>(
      listener: (context, state) {
        if (state is DoctorDetailsFailure) {
          CustomeSnackBar.showErrorSnackBar(context, msg: state.failureMsg);
        }
      },
      builder: (context, state) {
        if (state is DoctorDetailsLoading) {
          return const CustomeProgressIndicator();
        } else if (state is FetchDoctorDetailsSuccess) {
          return _Body(doctorModel: state.doctorModel);
        } else {
          return _Body(doctorModel: doctorModel);
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  final DoctorModel doctorModel;

  const _Body({required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    DoctorDetailsCubit cubit = BlocProvider.of<DoctorDetailsCubit>(context);
    return BlocConsumer<DoctorDetailsCubit, DoctorDetailsStates>(
      listener: (context, state) {
        if (state is DoctorDetailsFailure) {
          CustomeSnackBar.showErrorSnackBar(context, msg: state.failureMsg);
        }
      },
      builder: (context, state) {
        if (state is DoctorDetailsLoading) {
          return const CustomeProgressIndicator();
        } else if (state is DeleteDoctorAccountSuccess) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            cubit.close();
            Navigator.popUntil(
              context,
              (route) => route.isFirst,
            );
          });
          return DoctorsView(token: CacheHelper.getData(key: 'Token'));
        } else {
          return RefreshIndicator(
            onRefresh: () => cubit.refreshDoctor(doctorModel: doctorModel),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                SizedBox(height: 20.h),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: doctorModel.imagePath == 'default'
                      ? CustomeImage(
                          borderRadius: BorderRadius.circular(80.h),
                          height: 140.h,
                          iconSize: 50.sp,
                        )
                      : CustomeNetworkImage(
                          imageUrl: doctorModel.imagePath,
                          borderRadius: BorderRadius.circular(80.h),
                          height: 140.h,
                          fit: BoxFit.cover,
                        ),
                ),
                Column(
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'Dr. ${doctorModel.user.firstName} ${doctorModel.user.lastName}',
                      style: TextStyle(
                        fontSize: 20.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.7),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      // 'Cardiac Surgery Doctor',
                      '${doctorModel.specialty} Doctor',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(height: 6.5.h),
                    Text(
                      '(${doctorModel.review}.0 / 5) ⭐️',
                      style: TextStyle(
                        fontSize: 15.h,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DoctorDetailsButton(
                          text: 'Delete Account',
                          icon: const Icon(
                            Icons.delete,
                            size: 35,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            cubit.deleteDoctorAccount(doctorID: doctorModel.id);
                          },
                        ),
                        Container(
                          color: Colors.grey,
                          width: 1,
                          height: 40.h,
                        ),
                        DoctorDetailsButton(
                          text: 'Available Times',
                          icon: Icon(
                            Icons.schedule,
                            color: Colors.grey,
                            size: 30.w,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddWorkTimesView(
                                  doctorID: doctorModel.id,
                                  doctorTimes: cubit.doctorTimes.isEmpty
                                      ? null
                                      : cubit.doctorTimes,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            CustomeTextInfo(
                              text: 'Email: ${doctorModel.user.email}',
                              iconData: Icons.email,
                            ),
                            CustomeTextInfo(
                              text: 'Phone: ${doctorModel.user.phoneNum}',
                              iconData: Icons.phone,
                            ),
                            CustomeTextInfo(
                              text:
                                  'Consultation Price: ${doctorModel.consultationPrice}',
                              iconData: Icons.attach_money_rounded,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'About Doctor',
                              style: TextStyle(
                                fontSize: 15.h,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(.677),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              doctorModel.description,
                              // 'Doctorate in Psychiatry Postgraduate degree in Psychiatry\nBeirut University in 1996\nBoard Certified in Psychiatry',
                              style: TextStyle(
                                fontSize: 12.h,
                                color: Colors.black.withOpacity(.677),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
