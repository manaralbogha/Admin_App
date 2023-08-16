import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manage_app/core/api/services/local/cache_helper.dart';
import 'package:med_manage_app/cubit/states.dart';
import 'package:med_manage_app/modules/department/add_department_screen.dart';
import 'package:med_manage_app/modules/register_doctor_screen/register_doctor_screen.dart';
import 'package:med_manage_app/modules/register_secretaria/register_secretaria_screen.dart';
import 'package:med_manage_app/widgets/component.dart';
import '../cubit/cubit.dart';

class MedManageLayout extends StatelessWidget {
  const MedManageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit, MedManageStates>(
        builder: (context, state) {
          var cubit = MedManageCubit.get(context);
          return Scaffold(
            floatingActionButton: cubit.currentIndex != 1
                ? FloatingActionButton(
                    onPressed: () {
                      if (cubit.currentIndex == 0) {
                        navigateTo(
                            context,
                            AddDepartmentScreen(
                              model: cubit.departmentHomeModel,
                              index: MedManageCubit.index,
                            ));
                      } else if (cubit.currentIndex == 2) {
                        navigateTo(context, RegisterSecretaria());
                      } else {
                        Navigator.pushNamed(
                          context,
                          RegisterDoctorView.route,
                          arguments: CacheHelper.getData(key: "Token"),
                        );
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )
                : null,
            appBar: AppBar(
              title: const Text(
                'MedManage',
              ),
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.currentIndex = index;
                print(index);
                cubit.changeBottom(index);
              },
              items: cubit.items,
            ),
          );
        },
        listener: (context, state) {});
  }
}
