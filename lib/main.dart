import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_manage_app/core/utils/app_router.dart';
import 'package:med_manage_app/modules/doctors_screen/doctors_screen.dart';
import 'package:med_manage_app/styles/themes/themes.dart';
import 'core/api/services/local/cache_helper.dart';
import 'cubit/bloc_ob_server.dart';
import 'cubit/cubit.dart';
import 'helper/dio_helper.dart';

late Size screenSize;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  DioHelperG.init();

  // await CacheHelper.init();
  //token = CacheHelper.getData(key :'token');
  runApp(const MedManageApp());
}

class MedManageApp extends StatelessWidget {
  const MedManageApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MedManageCubit()..getHomeDepData(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: lightTheme, //light

            darkTheme: darkTheme, //dark

            //themeMode: MedManageCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light, //change between dark & light

            themeMode: ThemeMode.light,

            home: DoctorsView(token: CacheHelper.getData(key: 'Token')),
            // CacheHelper.getData(key: 'Token') == null
            //     ? const LoginView()
            //     : const MedManageLayout(),
            routes: AppRouter.router,
          );
        },
      ),
    );
  }
}

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }


