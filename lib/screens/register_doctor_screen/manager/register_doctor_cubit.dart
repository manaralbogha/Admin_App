import 'dart:developer';
import 'dart:io';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_admin_app/core/api/services/add_work_days_service.dart';
import 'package:project_one_admin_app/core/api/services/local/cache_helper.dart';
import 'package:project_one_admin_app/core/api/services/register_doctor_service.dart';
import 'package:project_one_admin_app/core/models/register_doctor_model.dart';
import 'package:project_one_admin_app/screens/register_doctor_screen/manager/register_doctor_states.dart';
import '../../../core/functions/custome_snack_bar.dart';

class RegisterDoctorCubit extends Cubit<RegisterDoctorStates> {
  RegisterDoctorModel registerModel = RegisterDoctorModel();

  bool obscureText = true;
  IconData icon = Icons.remove_red_eye;
  File? imageFile;
  final formKey = GlobalKey<FormState>();
  List<String> specialties = ['1', '2', '3', '4'];
  List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  List<String> times = [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '09:00 PM',
  ];
  List<String> nextTimes = [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '09:00 PM',
  ];
  List<dynamic> timeModels = [];
  String? specialty;

  RegisterDoctorCubit() : super(RegisterDoctorInitial());

  void selectSpecialty({required String specialty}) {
    emit(RegisterDoctorInitial());
    this.specialty = specialty;
    emit(AddSpecialtyState());
  }

  dynamic workTimes = {
    'Sunday': {'From': '', 'To': ''},
    'Monday': {'From': '', 'To': ''},
    'Tuesday': {'From': '', 'To': ''},
    'Wednesday': {'From': '', 'To': ''},
    'Thursday': {'From': '', 'To': ''},
    'Friday': {'From': '', 'To': ''},
    'Saturday': {'From': '', 'To': ''},
  };

  bool val(BuildContext context) {
    for (String key in workTimes.keys) {
      if (workTimes[key]['From'] != '' || workTimes[key]['To'] != '') {
        return true;
      }
    }
    CustomeSnackBar.showSnackBar(context,
        msg: 'Please enter at least one time',
        duration: const Duration(milliseconds: 3000),
        color: Colors.red);
    return false;
  }

  String validatorHelper({
    required int index,
    required String type,
  }) {
    if (workTimes[days[index]]['From'] == '' &&
        workTimes[days[index]]['To'] == '') return 'not requeued';
    return workTimes[days[index]][type];
  }

  void selectTime(
      {required String time, required int index, required String type}) {
    emit(RegisterDoctorInitial());
    workTimes[days[index]][type] = time;
    log(workTimes.toString());
    log(index.toString());
    emit(SelectTimeState());
  }

  void changePasswordState() {
    emit(RegisterDoctorInitial());
    obscureText = !obscureText;
    if (!obscureText) {
      icon = FontAwesomeIcons.solidEyeSlash;
    } else {
      icon = FontAwesomeIcons.solidEye;
    }
    emit(ChangePasswordState());
  }

  Future<void> registerDoctor({required String token}) async {
    if (imageFile != null) {
      registerModel.image = imageFile;
    }
    emit(RegisterDoctorLoading());
    (await RegisterDoctorService.registerDoctor(
            token: token, registerModel: registerModel))
        .fold(
      (failure) {
        emit(RegisterDoctorFailure(failureMsg: failure.errorMessege));
      },
      (registerRespone) {
        emit(RegisterDoctorSuccess(registerResponse: registerRespone));
      },
    );
  }

  // void storeTimes() {
  //   timeModels.clear();
  //   workTimes.forEach(
  //     (key, value) {
  //       if (value['From'] != '' && value['To'] != '') {
  //         timeModels.add(
  //           WorkTime(
  //             day: key,
  //             startTime: value['From'],
  //             endTime: value['To'],
  //           ),
  //         );
  //       }
  //     },
  //   );
  //   log('Time Models = ${timeModels.toString()}');
  // }

  void storeTimes({required String doctorID}) {
    timeModels.clear();
    workTimes.forEach(
      (key, value) {
        if (value['From'] != '' && value['To'] != '') {
          timeModels.add(
            {
              "day": key,
              "start_time": value['From'],
              "end_time": value['To'],
              "doctor_id": doctorID,
            },
          );
        }
      },
    );
    log('Time Models = ${timeModels.toString()}');
  }

  int nextTimesIndex = 0;
  bool allTimes = false;
  void setNextTimes() {
    nextTimes.clear();
    if (!allTimes) {
      // if (nextTimesIndex != 0) {
      for (int i = nextTimesIndex + 1; i < times.length; i++) {
        nextTimes.add(times[i]);
      }
      // }
    } else {
      for (String item in times) {
        nextTimes.add(item);
      }
    }
    // allTimes = !allTimes;
  }

  Future<void> setWorkTimes({required String doctorID}) async {
    emit(AddWorkTimesLoading());
    (await AddWorkDaysService.addWorkDays(
      token: CacheHelper.getData(key: 'Token'),
      docotrID: doctorID,
      body: timeModels,
    ))
        .fold(
      (failure) {
        emit(AddWorkTimesFailure(failureMsg: failure.errorMessege));
      },
      (workTimes) {
        emit(AddWorkTimesSuccess(workTimes: workTimes));
      },
    );
  }
}
