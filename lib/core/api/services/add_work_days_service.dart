import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import 'package:http/http.dart' as http;

abstract class AddWorkDaysService {
  static Future<Either<Failure, List<WorkTime>>> addWorkDays({
    required String token,
    required String docotrID,
    required List<dynamic> body,
  }) async {
    try {
      Map<String, String> headers = {};

      headers.addAll({'Authorization': 'Bearer $token'});
      const baseUrl = 'http://192.168.60.37:8000/api/';
      const endPoint = 'storeWorkDay';
      http.Response response = await http.post(Uri.parse('$baseUrl$endPoint'),
          body: body, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        log('HTTP POST Data: $data');
        List<WorkTime> workTimes = [];
        for (var item in data['data']) {
          workTimes.add(WorkTime.fromJson(item));
        }
        return right(workTimes);
      } else {
        throw Exception(
          'there is an error with status code ${response.statusCode} and with body : ${response.body}',
        );
      }

      // List<WorkTime> workTimes = [];
      // var data = await ApiServices.post(
      //   endPoint: 'storeWorkDay',
      //   body: {

      //   },
      //   token: token,
      // );

      // for (var item in data['data']) {
      //   workTimes.add(WorkTime.fromJson(item));
      // }

      // return right(workTimes);
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
  final String doctorID;

  WorkTime({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.doctorID,
  });

  factory WorkTime.fromJson(Map<String, dynamic> jsonData) {
    return WorkTime(
      id: jsonData['id'],
      day: jsonData['day'],
      startTime: jsonData['start_time'],
      endTime: jsonData['end_time'],
      doctorID: jsonData['doctor_id'],
    );
  }
}
