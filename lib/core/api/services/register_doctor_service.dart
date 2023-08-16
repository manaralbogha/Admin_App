import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../../models/register_doctor_model.dart';
import '../http_api_services.dart';

abstract class RegisterDoctorService {
  static Future<Either<Failure, RegisterDoctorResponse>> registerDoctor({
    required String token,
    required RegisterDoctorModel registerDoctorModel,
  }) async {
    try {
      var data = await ApiServices.postWithImage(
        endPoint: 'registerDoctor',
        body: {
          'email': registerDoctorModel.email!,
          'first_name': registerDoctorModel.firstName!,
          'last_name': registerDoctorModel.lastName!,
          'specialty': registerDoctorModel.specialty!,
          'password': registerDoctorModel.password!,
          'department_name': registerDoctorModel.departmentName!,
          'consultation_price': registerDoctorModel.consulationPrice!,
          'phone_num': registerDoctorModel.phoneNum!,
          'description': registerDoctorModel.description!,
        },
        imagePath: registerDoctorModel.image?.path,
        token: token,
      );
      return right(RegisterDoctorResponse.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in registerDoctor method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}

class RegisterDoctorResponse {
  final String token;
  final String role;
  final int userID;
  final int doctorID;

  RegisterDoctorResponse({
    required this.token,
    required this.role,
    required this.userID,
    required this.doctorID,
  });

  factory RegisterDoctorResponse.fromJson(Map<String, dynamic> jsonData) {
    return RegisterDoctorResponse(
      token: jsonData['token'],
      role: jsonData['role'],
      userID: jsonData['doctor']['user_id'],
      doctorID: jsonData['doctor']['id'],
    );
  }
}
