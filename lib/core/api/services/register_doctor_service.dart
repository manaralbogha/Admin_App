import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_one_admin_app/core/api/http_api_services.dart';
import '../../errors/failures.dart';
import '../../models/register_doctor_model.dart';

abstract class RegisterDoctorService {
  static Future<Either<Failure, RegisterDoctorResponse>> registerDoctor(
      {required String token,
      required RegisterDoctorModel registerModel}) async {
    try {
      // var file =
      //     await http.MultipartFile.fromPath('jpg', registerModel.image!.path);
      var data = await ApiServices.post(
        endPoint: 'registerDoctor',
        body: {
          'email': registerModel.email,
          'first_name': registerModel.firstName,
          'last_name': registerModel.lastName,
          'specialty': registerModel.specialty,
          'password': registerModel.password,
          'department_name': 'department two',
          'consultation_price': registerModel.consulationPrice,
          'phone_num': registerModel.phoneNum,
          'description': 'ab3zab1234567899',
          // 'img': file,
        },
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
