import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_one_admin_app/core/api/http_api_services.dart';
import '../../errors/failures.dart';
import '../../models/message_model.dart';

abstract class DeleteDoctorService {
  static Future<Either<Failure, MessageModel>> deleteDoctor(
      {required String token, required int userID}) async {
    try {
      var data = await ApiServices.post(
          endPoint: 'deleteDoctor', body: {'user_id': '$userID'}, token: token);

      return right(MessageModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in deleteDoctor method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
