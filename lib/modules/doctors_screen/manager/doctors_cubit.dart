import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api/services/delete_doctor_service.dart';
import '../../../core/api/services/get_doctors_service.dart';
import '../../../core/functions/custome_snack_bar.dart';
import 'doctors_states.dart';

class DoctorCubit extends Cubit<DoctorsStates> {
  DoctorCubit() : super(DoctorsLoading());

  Future<void> getDoctors({required String token}) async {
    emit(DoctorsLoading());
    (await GetDoctorsService.getDoctors(token: token)).fold(
      (failure) {
        if (isClosed) return;
        emit(DoctorsFailure(failureMsg: failure.errorMessege));
      },
      (doctors) {
        if (isClosed) return;
        emit(DoctorsSuccess(doctors: doctors));
      },
    );
  }

  Future<void> deleteDoctor(context,
      {required String token, required int doctorID}) async {
    (await DeleteDoctorService.deleteDoctor(token: token, doctorID: doctorID))
        .fold(
      (failure) {
        emit(DoctorsFailure(failureMsg: failure.errorMessege));
      },
      (success) {
        emit(DeleteDoctorSuccess());
        CustomeSnackBar.showSnackBar(context,
            msg: 'Doctor Deleted Successfully');
        getDoctors(token: token);
      },
    );
  }
}
