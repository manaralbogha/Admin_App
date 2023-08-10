import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_admin_app/core/api/services/delete_doctor_service.dart';
import 'package:project_one_admin_app/core/api/services/get_department_details_service.dart';
import 'package:project_one_admin_app/core/api/services/get_work_days_service.dart';
import 'package:project_one_admin_app/core/api/services/local/cache_helper.dart';
import 'package:project_one_admin_app/core/functions/custome_snack_bar.dart';
import 'package:project_one_admin_app/core/models/department_model.dart';
import 'package:project_one_admin_app/core/models/doctor_model.dart';
import 'package:project_one_admin_app/core/models/work_day_model.dart';
import 'package:project_one_admin_app/screens/doctor_details_screen/manager/doctor_details_states.dart';

import '../../../core/api/services/get_doctor_details_service.dart';
import '../../../core/api/services/update_doctor_details_service.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsStates> {
  String? doctorImage;
  String? consultationPrice;
  String? phoneNum;
  String? description;
  bool edit = false;
  List<WorkDayModel> doctorTimes = [];
  DepartmentModel? departmentModel;
  DoctorDetailsCubit() : super(DoctorDetailsInitial());

  void editDoctorInfo() {
    edit = !edit;
    emit(DoctorDetailsEdit());
  }

  Future<void> storeDoctorWorkDays({required int doctorID}) async {
    emit(DoctorDetailsLoading());
    (await GetWorkDaysService.getWorkDays(
            token: CacheHelper.getData(key: 'Token')))
        .fold(
      (failure) => emit(DoctorDetailsFailure(failureMsg: failure.errorMessege)),
      (allWorkDays) {
        emit(GetWorkTimesSuccess());
        doctorTimes = getDoctorWorkDays(
          doctorID: doctorID,
          workDays: allWorkDays,
        );
      },
    );
  }

  List<WorkDayModel> getDoctorWorkDays({
    required int doctorID,
    required List<WorkDayModel> workDays,
  }) {
    List<WorkDayModel> list = [];
    for (var workDayModel in workDays) {
      if (workDayModel.doctorID == doctorID) {
        list.add(workDayModel);
      }
    }
    return list;
  }

  Future<void> deleteDoctorAccount({required int userID}) async {
    emit(DoctorDetailsLoading());

    (await DeleteDoctorService.deleteDoctor(
            token: CacheHelper.getData(key: 'Token'), userID: userID))
        .fold(
      (failure) => emit(DoctorDetailsFailure(failureMsg: failure.errorMessege)),
      (success) => emit(DeleteDoctorAccountSuccess()),
    );
  }

  Future<void> getDoctorDepartment({required int departmentID}) async {
    emit(DoctorDetailsLoading());
    (await GetDepartmentDetailsService.getDepartmentDetails(
      token: CacheHelper.getData(key: 'Token'),
      departmentID: departmentID,
    ))
        .fold(
      (failure) {
        emit(DoctorDetailsFailure(failureMsg: failure.errorMessege));
      },
      (departmentModel) {
        this.departmentModel = departmentModel;
        emit(DoctorDetailsInitial());
      },
    );
  }

  Future<void> updateDoctorDetails(
    BuildContext context, {
    required DoctorModel doctorModel,
  }) async {
    emit(DoctorDetailsLoading());
    if (doctorImage != null) {
      (await UpdateDoctorDetailsService.updateWithImage(
        doctorModel: doctorModel,
        deparmentName: departmentModel!.name,
      ))
          .fold(
        (failure) {
          emit(DoctorDetailsFailure(failureMsg: failure.errorMessege));
          Navigator.pop(context);
          CustomeSnackBar.showErrorSnackBar(context, msg: failure.errorMessege);
        },
        (success) async {
          (await GetDoctorDetailsService.getDoctorDetails(
                  userID: doctorModel.userID))
              .fold(
            (failure) {
              emit(DoctorDetailsFailure(failureMsg: failure.errorMessege));
              Navigator.pop(context);
              CustomeSnackBar.showErrorSnackBar(context,
                  msg: failure.errorMessege);
            },
            (doctorModel) {
              emit(FetchDoctorDetailsSuccess(doctorModel: doctorModel));
              Navigator.pop(context);
            },
          );
        },
      );
      log('update with image zzzzzzzzzzzzzzzz');
    } else {
      (await UpdateDoctorDetailsService.updateDoctorDetails(
        doctorModel: doctorModel,
        deparmentName: departmentModel!.name,
      ))
          .fold(
        (failure) {
          emit(DoctorDetailsFailure(failureMsg: failure.errorMessege));
          Navigator.pop(context);
          CustomeSnackBar.showErrorSnackBar(context, msg: failure.errorMessege);
        },
        (success) async {
          (await GetDoctorDetailsService.getDoctorDetails(
                  userID: doctorModel.userID))
              .fold(
            (failure) {
              emit(DoctorDetailsFailure(failureMsg: failure.errorMessege));
              Navigator.pop(context);
              CustomeSnackBar.showErrorSnackBar(context,
                  msg: failure.errorMessege);
            },
            (doctorModel) {
              emit(FetchDoctorDetailsSuccess(doctorModel: doctorModel));
              Navigator.pop(context);
            },
          );
        },
      );
      log('update without image zzzzzzzzzzzzzzzz');
    }
  }
}
