import 'package:dio/dio.dart';
import 'package:med_manage_app/constant.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        /*headers:
        {
          'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMjA1NTJkMzE3ZDQyMzBjMjhjYTI1NGQzNjk4NzU0MDI4NWQzNjM0YzI0MzA0NGRmMzA0NzVlYTY1NjBiNjUxMTEyZjAzY2YyMjQ3Y2RlMzUiLCJpYXQiOjE2ODk4NTc0NTcuNTE1Njk3LCJuYmYiOjE2ODk4NTc0NTcuNTE1NzA2LCJleHAiOjE3MjE0Nzk4NTcuNDg4NDk4LCJzdWIiOiIyMSIsInNjb3BlcyI6W119.qz57UmimCCCF0Gb76I0e5yO8vUjR_DO5g4u92tS9WJIhmfkUZPsDgGjn6CnVakX7zIPIUqIwFcRJHjIlzaAMbxQCIWpEvL978Lv5EUNjnrn8jZUIubsUaQ3S504aGLnjqIXsEouyHI94yvlFt0VlewdGlbaJ6SW1Bv3aD0w8SvgFhvbKkITdDGUGt1X_7x4GWiaoyTaP0I6hPKiJHqD3MxEaKiFMT_obKP6BEBAcaXvY-2AYbIH4JenEydfiQE2lOSmv2zxrF7vmv7COk_kF2wDwZ08OhXMyPeJ9fEjFDhQ2bJ-3NVH9zkCTQQSyVMlzc0KEV3mUNKBn667gPHQKftH2QGo3FEqzfdwS_B4EzVeL4e1_wJ5raBFygFlOKiIRl9wpu-5cRL213oS3FxcJnky8KPsbdZtl-fPo63s17SzJKyItV0F0b9pt3C9hDYzXoLbWu9g_R5qVePVtjHlsVI15zk0LjOClf6WBJ0xrQ5vkptAQQf2cdg1_kp3qrQslGHe4qPLce9aF6mx7hixougUhFuFZzGlstVN8eLowIYnR5BKBtAaz8maQWnfhRMP9gg0jHeUXxT8JYOgBYYCl8Qfci3bc5fsrMNRtLh_BzyIDEh5cja7K3LV1v_nfdTiCUlp0i9K0MiKZWvQkgjOuXx3NLYZ70WDdVnM_SLkQByE'
        },*/
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    required String token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}

/*
*
* dio.options.headers=
    {
      'Authorization': 'Bearer $token',
      'Postman-Token': '<calculated when request is sent>',
      'Host': '<calculated when request is sent>',
      'User-Agent': 'PostmanRuntime/7.32.3',
      //'Accept': '',
      //'Accept-Encoding': 'gzip, deflate, br',
      //'Connection':'keep-alive',

};*/

//gh api method**********************************************************************************
class DioHelperG {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getDataG({
    required String url,
    required Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postDataG({
    required String url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
