import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_admin_app/core/api/services/delete_doctor_service.dart';
import 'package:project_one_admin_app/core/api/services/get_doctors_service.dart';
import 'package:project_one_admin_app/core/functions/custome_snack_bar.dart';
import 'package:project_one_admin_app/screens/doctors_screen/manager/doctors_states.dart';

class DoctorCubit extends Cubit<DoctorsStates> {
  DoctorCubit() : super(DoctorsLoading());

  Future<void> getDoctors({required String token}) async {
    emit(DoctorsLoading());
    (await GetDoctorsService.getDoctors(token: token)).fold(
      (failure) {
        emit(DoctorsFailure(failureMsg: failure.errorMessege));
      },
      (doctors) {
        emit(DoctorsSuccess(doctors: doctors));
      },
    );
  }

  Future<void> deleteDoctor(context,
      {required String token, required int userID}) async {
    (await DeleteDoctorService.deleteDoctor(token: token, userID: userID)).fold(
      (failure) {
        emit(DoctorsFailure(failureMsg: failure.errorMessege));
      },
      (messageModel) {
        emit(DeleteDoctorSuccess(messageModel: messageModel));
        CustomeSnackBar.showSnackBar(context,
            msg: 'Doctor Deleted Successfully');
        getDoctors(token: token);
      },
    );
  }
}
