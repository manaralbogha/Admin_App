import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../../models/message_model.dart';
import '../../models/work_day_model.dart';
import '../http_api_services.dart';

abstract class UpdateWorkDaysService {
  static Future<Either<Failure, MessageModel>> updateWorkDays({
    required String token,
    required WorkDayModel workDayModel,
  }) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'updateWorkDay',
        body: {
          'day': workDayModel.day,
          'start_time': workDayModel.startTime,
          'end_time': workDayModel.endTime,
          'id': workDayModel.id,
          'user_id': workDayModel.doctorID,
        },
        token: token,
      );

      return right(MessageModel.fromJson(data));
    } catch (ex) {
      log('Exception: there is an error in updateWorkDays method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
