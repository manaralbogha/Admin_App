import 'package:flutter/cupertino.dart';
import '../../helper/cache_helper.dart';
import '../../modules/doctor_details_screen/doctor_details_screen.dart';
import '../../modules/doctors_screen/doctors_screen.dart';
import '../../modules/login_screen/login_screen.dart';
import '../../modules/register_doctor_screen/register_doctor_screen.dart';

abstract class AppRouter {
  static final router = <String, WidgetBuilder>{
    LoginView.route: (context) => const LoginView(),
    DoctorDetailsView.route: (context) => const DoctorDetailsView(),
    RegisterDoctorView.route: (context) => const RegisterDoctorView(),
    DoctorsView.route: (context) =>
        DoctorsView(token: CacheHelper.getData(key: 'Token')),
  };
}
