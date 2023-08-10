import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_one_admin_app/core/api/http_api_services.dart';
import 'package:project_one_admin_app/core/api/services/local/cache_helper.dart';
import 'package:project_one_admin_app/core/models/doctor_model.dart';
import '../../errors/failures.dart';

abstract class UpdateDoctorDetailsService {
  static Future<Either<Failure, void>> updateWithImage(
      {required DoctorModel doctorModel, required String deparmentName}) async {
    try {
      ApiServices.postWithImage(
        endPoint: 'updateDoctor',
        body: {
          'user_id': "${doctorModel.user.id}",
          'first_name': doctorModel.user.firstName,
          'last_name': doctorModel.user.lastName,
          'specialty': doctorModel.specialty,
          'department_id': "${doctorModel.departmentID}",
          'consultation_price': "${doctorModel.consultationPrice}",
          'phone_num': doctorModel.user.phoneNum,
          'department_name': deparmentName,
        },
        imagePath: doctorModel.imagePath,
        token: CacheHelper.getData(key: 'Token'),
      );
      return right(null);
    } catch (ex) {
      log('Exception: there is an error in updateWithImage method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  static Future<Either<Failure, void>> updateDoctorDetails(
      {required DoctorModel doctorModel, required String deparmentName}) async {
    try {
      await ApiServices.post(
        endPoint: 'updateDoctor',
        body: {
          'user_id': "${doctorModel.user.id}",
          'first_name': doctorModel.user.firstName,
          'last_name': doctorModel.user.lastName,
          'specialty': doctorModel.specialty,
          'department_id': "${doctorModel.departmentID}",
          'consultation_price': "${doctorModel.consultationPrice}",
          'phone_num': doctorModel.user.phoneNum,
          'department_name': deparmentName,
        },
        token: CacheHelper.getData(key: 'Token'),
      );

      return right(null);
    } catch (ex) {
      log('Exception: there is an error in updateDoctorDetails method');
      log(ex.toString());
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
