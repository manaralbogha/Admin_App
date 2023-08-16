import 'dart:developer';
import 'dart:io';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manage_app/modules/register_doctor_screen/manager/register_doctor_states.dart';
import '../../../core/api/services/add_work_days_service.dart';
import '../../../core/api/services/delete_work_day_service.dart';
import '../../../core/api/services/get_departments_service.dart';
import '../../../core/api/services/local/cache_helper.dart';
import '../../../core/api/services/register_doctor_service.dart';
import '../../../core/functions/custome_dialogs.dart';
import '../../../core/functions/custome_snack_bar.dart';
import '../../../core/models/register_doctor_model.dart';
import '../../../core/models/work_day_model.dart';
import '../../../main.dart';

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
  List<Map<String, String>> timeModels = [];
  String? specialty;
  String? department;

  RegisterDoctorCubit() : super(RegisterDoctorInitial());

  void selectSpecialty({required String specialty}) {
    emit(RegisterDoctorInitial());
    this.specialty = specialty;
    emit(SelectSpecialtyState());
  }

  void selectDepartment({required String department}) {
    emit(RegisterDoctorInitial());
    this.department = department;
    emit(SelectSpecialtyState());
  }

  dynamic workTimes = {
    'Sunday': {'From': '__', 'To': '__'},
    'Monday': {'From': '__', 'To': '__'},
    'Tuesday': {'From': '__', 'To': '__'},
    'Wednesday': {'From': '__', 'To': '__'},
    'Thursday': {'From': '__', 'To': '__'},
    'Friday': {'From': '__', 'To': '__'},
    'Saturday': {'From': '__', 'To': '__'},
  };

  bool val(BuildContext context) {
    for (String key in workTimes.keys) {
      if (workTimes[key]['From'] != '__' || workTimes[key]['To'] != '__') {
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
    if (workTimes[days[index]]['From'] == '__' &&
        workTimes[days[index]]['To'] == '__') return 'not required';
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
            token: token, registerDoctorModel: registerModel))
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
        if (value['From'] != '__' && value['To'] != '__') {
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
    for (var item in timeModels) {
      log("${item["doctor_id"]} is ${item["doctor_id"].runtimeType}");
      log('${item['day']}: From${item['start_time']} =>To${item['end_time']}');
    }
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
    emit(WorkTimesLoading());
    (await AddWorkDaysService.addWorkDays(
      token: CacheHelper.getData(key: 'Token'),
      // docotrID: doctorID,
      body: timeModels,
    ))
        .fold(
      (failure) {
        emit(WorkTimesFailure(failureMsg: failure.errorMessege));
      },
      (workTimes) {
        emit(WorkTimesSuccess());
      },
    );
  }

  Future<void> getDepartments(BuildContext context) async {
    (await GetDepartmentsService.getDepartments(
            token: await CacheHelper.getData(key: 'Token')))
        .fold(
      (failure) {
        emit(RegisterDoctorFailure(failureMsg: failure.errorMessege));
      },
      (departments) {
        emit(GetDepartmentsSuccess(departments: departments));
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: SizedBox(
                height: screenSize.height * .4,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      departments.length,
                      (index) => SpecialityDialogButton(
                        onTap: () {
                          registerModel.departmentName =
                              departments[index].name;
                          selectDepartment(
                            department: departments[index].name,
                          );
                          Navigator.pop(context);
                        },
                        specialty: departments[index].name,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void setComingDoctorTimes({required List<WorkDayModel> list}) {
    for (WorkDayModel model in list) {
      workTimes[model.day]['From'] = model.startTime;
      workTimes[model.day]['To'] = model.endTime;
    }
  }

  WorkDayModel? getDoctorWorkTimeModel(
      {required List<WorkDayModel> list, required String day}) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].day == day) {
        return list[i];
      }
    }
    return null;
  }

  Future<void> deleteDoctorWorkDays({required List<WorkDayModel>? list}) async {
    if (list != null && list.isNotEmpty) {
      emit(WorkTimesLoading());
      for (WorkDayModel item in list) {
        (await DeleteWorkDayService.deleteWorkDay(
                token: CacheHelper.getData(key: 'Token'), id: item.id))
            .fold(
          (failure) => emit(WorkTimesFailure(failureMsg: failure.errorMessege)),
          (success) {},
        );
      }
    }
  }
}
