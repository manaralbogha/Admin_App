import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_admin_app/screens/doctor_details_screen/manager/doctor_details_states.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsStates> {
  bool edit = false;
  DoctorDetailsCubit() : super(DoctorDetailsInitial());

  void editDoctorInfo() {
    edit = !edit;
    emit(DoctorDetailsEdit());
  }
}
