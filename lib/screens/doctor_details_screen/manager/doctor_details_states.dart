import 'package:equatable/equatable.dart';
import 'package:project_one_admin_app/core/models/doctor_model.dart';

abstract class DoctorDetailsStates extends Equatable {
  @override
  List<Object> get props => [];
}

class DoctorDetailsInitial extends DoctorDetailsStates {}

class DoctorDetailsEdit extends DoctorDetailsStates {}

class DoctorDetailsLoading extends DoctorDetailsStates {}

class DoctorDetailsFailure extends DoctorDetailsStates {
  final String failureMsg;

  DoctorDetailsFailure({required this.failureMsg});
}

class GetWorkTimesSuccess extends DoctorDetailsStates {}

class DeleteDoctorAccountSuccess extends DoctorDetailsStates {}

class FetchDoctorDetailsSuccess extends DoctorDetailsStates {
  final DoctorModel doctorModel;

  FetchDoctorDetailsSuccess({required this.doctorModel});
}
