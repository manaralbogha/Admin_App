import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_one_admin_app/core/api/http_api_services.dart';
import 'package:project_one_admin_app/core/models/doctor_model.dart';
import '../../errors/failures.dart';
import '../../models/message_model.dart';

abstract class UpdateDoctorDetailsService {
  static Future<Either<Failure, MessageModel>> updateDoctorDetails(
      {required String token, required DoctorModel doctorModel}) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'updateDoctor',
        body: {
          'user_id': doctorModel.user.id,
          'first_name': doctorModel.user.firstName,
          'last_name': doctorModel.user.lastName,
          'specialty': doctorModel.specialty,
          'department_id': doctorModel.departmentID,
          'consultation_price': doctorModel.consultationPrice,
          'phone_num': doctorModel.user.phoneNum,
          'img': '',
        },
        token: token,
      );

      return right(MessageModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in updateDoctorDetails method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
