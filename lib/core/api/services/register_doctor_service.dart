import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_one_admin_app/core/api/http_api_services.dart';
import 'package:project_one_admin_app/core/api/services/login_service.dart';
import '../../errors/failures.dart';
import '../../models/register_doctor_model.dart';

abstract class RegisterDoctorService {
  static Future<Either<Failure, LoginModel>> registerDoctor(
      {required String token,
      required RegisterDoctorModel registerModel}) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'registerDoctor',
        body: {
          'email': registerModel.email,
          'first_name': registerModel.firstName,
          'last_name': registerModel.lastName,
          'specialty': registerModel.specialty,
          'password': registerModel.password,
          'department_id': '1',
          'consultation_price': registerModel.consulationPrice,
          'phone_num': registerModel.phoneNum,
          'img': registerModel.image,
        },
        token: token,
      );

      return right(LoginModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in registerDoctor method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
