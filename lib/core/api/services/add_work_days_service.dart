import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_one_admin_app/core/api/http_api_services.dart';
import '../../errors/failures.dart';

abstract class AddWorkDaysService {
  static Future<Either<Failure, List<WorkTime>>> addWorkDays({
    required String token,
    required String userID,
    required List<Map<String, String>> times,
  }) async {
    try {
      List<WorkTime> workTimes = [];
      var data = await ApiServices.post(
        endPoint: 'storeWorkDay',
        body: {
          'user_id': userID,
          'workDay': times,
        },
        token: token,
      );

      for (var item in data['data']) {
        workTimes.add(WorkTime.fromJson(item));
      }

      return right(workTimes);
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
  final int id;
  final String day;
  final String startTime;
  final String endTime;
  final int userID;

  WorkTime({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.userID,
  });

  factory WorkTime.fromJson(Map<String, dynamic> jsonData) {
    return WorkTime(
      id: jsonData['id'],
      day: jsonData['day'],
      startTime: jsonData['start_time'],
      endTime: jsonData['end_time'],
      userID: jsonData['doctor_id'],
    );
  }
}
