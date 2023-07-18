import 'package:equatable/equatable.dart';
import 'package:project_one_admin_app/core/models/doctor_model.dart';
import 'package:project_one_admin_app/core/models/message_model.dart';

abstract class DoctorsStates extends Equatable {
  @override
  List<Object> get props => [];
}

// class DoctorsInitial extends DoctorsStates {}

class DoctorsLoading extends DoctorsStates {}

class DoctorsSuccess extends DoctorsStates {
  final List<DoctorModel> doctors;

  DoctorsSuccess({required this.doctors});
}

class DoctorsFailure extends DoctorsStates {
  final String failureMsg;

  DoctorsFailure({required this.failureMsg});
}

class DeleteDoctorSuccess extends DoctorsStates {
  final MessageModel messageModel;

  DeleteDoctorSuccess({required this.messageModel});
}
