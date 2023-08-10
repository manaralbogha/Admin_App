import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../errors/failures.dart';
import '../../models/department_model.dart';
import '../http_api_services.dart';

abstract class GetDepartmentDetailsService {
  static Future<Either<Failure, DepartmentModel>> getDepartmentDetails(
      {required String token, required int departmentID}) async {
    try {
      var data = await ApiServices.post(
        endPoint: 'viewDepartment',
        token: token,
        body: {'id': '$departmentID'},
      );

      return right(DepartmentModel.fromJson(data['item']));
    } catch (ex) {
      log('Exception: there is an error in getDepartmentDetails method');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
