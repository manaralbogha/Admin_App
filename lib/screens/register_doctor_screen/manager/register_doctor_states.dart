import 'package:equatable/equatable.dart';
import 'package:project_one_admin_app/core/api/services/register_doctor_service.dart';
import 'package:project_one_admin_app/core/models/department_model.dart';

abstract class RegisterDoctorStates extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterDoctorInitial extends RegisterDoctorStates {}

class RegisterDoctorLoading extends RegisterDoctorStates {}

class RegisterDoctorSuccess extends RegisterDoctorStates {
  final RegisterDoctorResponse registerResponse;

  RegisterDoctorSuccess({required this.registerResponse});
}

class RegisterDoctorFailure extends RegisterDoctorStates {
  final String failureMsg;

  RegisterDoctorFailure({required this.failureMsg});
}

class SelectSpecialtyState extends RegisterDoctorStates {}

class SelectDepartmentState extends RegisterDoctorStates {}

class GetDepartmentsSuccess extends RegisterDoctorStates {
  final List<DepartmentModel> departments;

  GetDepartmentsSuccess({required this.departments});
}

class SelectTimeState extends RegisterDoctorStates {}

class ChangePasswordState extends RegisterDoctorStates {}

class AddWorkTimesLoading extends RegisterDoctorStates {}

class AddWorkTimesSuccess extends RegisterDoctorStates {
  // final List<WorkTime> workTimes;

  AddWorkTimesSuccess();
  // AddWorkTimesSuccess({required this.workTimes});
}

class AddWorkTimesFailure extends RegisterDoctorStates {
  final String failureMsg;

  AddWorkTimesFailure({required this.failureMsg});
}
