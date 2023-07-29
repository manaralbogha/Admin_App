import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import 'package:http/http.dart' as http;

abstract class AddWorkDaysService {
  static const _baseUrl = 'http://192.168.43.37:8000/api/';
  static const _endPoint = 'storeWorkDay';
  static Future<Either<Failure, void>> addWorkDays({
    required String token,
    required List<Map<String, String>> body,
  }) async {
    try {
      Map<String, String> headers = {};
      headers.addAll({'Authorization': 'Bearer $token'});
      http.Response response = await http.post(
        Uri.parse('$_baseUrl$_endPoint'),
        body: json.encode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return right(null);
      } else {
        throw Exception(
          'there is an error with status code ${response.statusCode} and with body : ${response.body}',
        );
      }
    } catch (ex) {
      log('Exception: there is an error in addWorkDays method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}

// class WorkTime {
//   final int id;
//   final String day;
//   final String startTime;
//   final String endTime;
//   final String doctorID;

//   WorkTime({
//     required this.id,
//     required this.day,
//     required this.startTime,
//     required this.endTime,
//     required this.doctorID,
//   });

//   factory WorkTime.fromJson(Map<String, dynamic> jsonData) {
//     return WorkTime(
//       id: jsonData['id'],
//       day: jsonData['day'],
//       startTime: jsonData['start_time'],
//       endTime: jsonData['end_time'],
//       doctorID: jsonData['doctor_id'],
//     );
//   }
// }
