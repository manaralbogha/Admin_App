import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_one_admin_app/core/api/http_api_services.dart';
import '../../errors/failures.dart';
import '../../models/message_model.dart';

abstract class AddWorkDaysService {
  static Future<Either<Failure, MessageModel>> addWorkDays({
    required String token,
    required WorkTime workTime,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'storeWorkDay',
        body: {
          'day': workTime.day,
          'start_time': workTime.startTime,
          'end_time': workTime.endTime,
          'user_id': workTime.userID,
        },
        token: token,
      );

      return right(MessageModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in addWorkDays method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}

class WorkTime {
  final String? day;
  final String? startTime;
  final String? endTime;
  final int? userID;

  WorkTime({
    this.day,
    this.startTime,
    this.endTime,
    this.userID,
  });
}
