import 'package:equatable/equatable.dart';

abstract class DoctorDetailsStates extends Equatable {
  @override
  List<Object> get props => [];
}

class DoctorDetailsInitial extends DoctorDetailsStates {}

class DoctorDetailsEdit extends DoctorDetailsStates {}
