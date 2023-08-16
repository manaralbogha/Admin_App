import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../../models/work_day_model.dart';
import '../http_api_services.dart';

abstract class GetWorkDaysService {
  static Future<Either<Failure, List<WorkDayModel>>> getWorkDays(
      {required String token}) async {
    try {
      var data = await ApiServices.get(endPoint: 'indexWorkDay', token: token);
      List<WorkDayModel> workDays = [];
      for (var item in data['data']) {
        workDays.add(WorkDayModel.fromJson(item));
      }
      return right(workDays);
    } catch (ex) {
      log('Exception: there is an error in getWorkDays method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
