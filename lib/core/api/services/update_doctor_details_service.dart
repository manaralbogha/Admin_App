import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../../models/doctor_model.dart';
import '../http_api_services.dart';

abstract class UpdateDoctorDetailsService {
  static Future<Either<Failure, void>> updateWithImage({
    required DoctorModel doctorModel,
    required String deparmentName,
    required String token,
  }) async {
    try {
      ApiServices.postWithImage(
        endPoint: 'updateDoctor',
        body: {
          'id': "${doctorModel.id}",
          'first_name': doctorModel.user.firstName,
          'last_name': doctorModel.user.lastName,
          'email': doctorModel.user.email,
          'specialty': doctorModel.specialty,
          'consultation_price': "${doctorModel.consultationPrice}",
          'phone_num': doctorModel.user.phoneNum,
          'department_name': deparmentName,
          'description': doctorModel.description,
        },
        imagePath: doctorModel.imagePath,
        token: token,
      );
      return right(null);
    } catch (ex) {
      log('Exception: there is an error in updateWithImage method');
      log('xxx ${ex.toString()} xxx');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  static Future<Either<Failure, void>> updateDoctorDetails({
    required DoctorModel doctorModel,
    required String deparmentName,
    required String token,
  }) async {
    try {
      await ApiServices.post(
        endPoint: 'updateDoctor',
        body: {
          'id': "${doctorModel.id}",
          'first_name': doctorModel.user.firstName,
          'last_name': doctorModel.user.lastName,
          'email': doctorModel.user.email,
          'specialty': doctorModel.specialty,
          'consultation_price': "${doctorModel.consultationPrice}",
          'phone_num': doctorModel.user.phoneNum,
          'department_name': deparmentName,
          'description': doctorModel.description,
        },
        token: token,
      );

      return right(null);
    } catch (ex) {
      log('Exception: there is an error in updateDoctorDetails method');
      log('xxx ${ex.toString()} xxx');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
