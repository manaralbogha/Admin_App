import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../../models/message_model.dart';
import '../http_api_services.dart';

abstract class DeleteWorkDayService {
  static Future<Either<Failure, MessageModel>> deleteWorkDay(
      {required String token, required int id}) async {
    try {
      var data = await ApiServices.post(
          endPoint: 'deleteWorkDay', body: {'id': '$id'}, token: token);

      return right(MessageModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in deleteWorkDay method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
