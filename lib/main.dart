import 'package:flutter/material.dart';
import 'package:project_one_admin_app/core/api/services/local/cache_helper.dart';
import 'package:project_one_admin_app/core/styles/colors/colors.dart';
import 'package:project_one_admin_app/screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:project_one_admin_app/screens/doctors_screen/doctors_screen.dart';
import 'package:project_one_admin_app/screens/login_screen/login_screen.dart';
import 'package:project_one_admin_app/screens/register_doctor_screen/register_doctor_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const AdminApp());
}

late Size screenSize;

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          initialRoute: CacheHelper.getData(key: 'Token') == null
              ? LoginView.route
              : DoctorsView.route,
          routes: {
            LoginView.route: (context) => const LoginView(),
            DoctorDetailsView.route: (context) => const DoctorDetailsView(),
            RegisterDoctorView.route: (context) => const RegisterDoctorView(),
            // AddWorkTimesView.route: (context) => const AddWorkTimesView(),
            DoctorsView.route: (context) =>
                DoctorsView(token: CacheHelper.getData(key: 'Token')),
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: defaultColor,
              centerTitle: true,
            ),
          ),
        );
      },
    );
  }
}
