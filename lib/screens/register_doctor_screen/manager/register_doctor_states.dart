import 'package:equatable/equatable.dart';
import 'package:project_one_admin_app/core/api/services/add_work_days_service.dart';
import 'package:project_one_admin_app/core/api/services/register_doctor_service.dart';

abstract class RegisterDoctorStates extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterDoctorInitial extends RegisterDoctorStates {}

class RegisterDoctorLoading extends RegisterDoctorStates {}

// class RegisterDoctorSuccess extends RegisterDoctorStates {
//   final LoginModel loginModel;

//   RegisterDoctorSuccess({required this.loginModel});
// }

class RegisterDoctorSuccess extends RegisterDoctorStates {
  final RegisterDoctorResponse registerResponse;

  RegisterDoctorSuccess({required this.registerResponse});
}

class RegisterDoctorFailure extends RegisterDoctorStates {
  final String failureMsg;

  RegisterDoctorFailure({required this.failureMsg});
}

class AddSpecialtyState extends RegisterDoctorStates {}

class SelectTimeState extends RegisterDoctorStates {}

class ChangePasswordState extends RegisterDoctorStates {}

class AddWorkTimesLoading extends RegisterDoctorStates {}

class AddWorkTimesSuccess extends RegisterDoctorStates {
  final List<WorkTime> workTimes;

  AddWorkTimesSuccess({required this.workTimes});
}

class AddWorkTimesFailure extends RegisterDoctorStates {
  final String failureMsg;

  AddWorkTimesFailure({required this.failureMsg});
}
