import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../models/secretaria/index_secretaria_model.dart';
import '../modules/register_secretaria/register_secretaria_screen.dart';
import '../modules/secretaria_profile/secretaria_profile-screen.dart';
import '../styles/colors/colors.dart';
import 'component.dart';
import 'custome_image.dart';

class SecretariaListViewItem extends StatelessWidget {

  final String? profImage;
  final IndexSecretariaModel model;

  const SecretariaListViewItem(
      BuildContext? context, {
        super.key,
        this.profImage,
        required this.model,
      });


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! MedManageLoadingSecretariaListState,
          builder: (context) => model.secretary.isNotEmpty ?
          ListView.separated(
            itemBuilder: (context, index) =>
              GestureDetector(
                onTap: () {
                  MedManageCubit.get(context).viewSecretaria(
                    user_id: model.secretary[index < 0 ? 0 : index].userId,
                  );
                  navigateTo(context, SecretariaProfile(index: index < 0 ? 0 : index,),);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .14,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 15.0,
                      end: 8.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: [
                        CustomeImage(
                          image: 'assets/images/undraw_Male_avatar_g98d (1).png',
                          width: MediaQuery.of(context).size.height * .13,
                          height: MediaQuery.of(context).size.height * .13,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: 15.0,
                              bottom: 0.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    model.secretary[index < 0 ? 0 : index].user.firstName,
                                    style: const TextStyle(
                                      color: defaultColor,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    model.secretary[index < 0 ? 0 : index].user.phoneNum,
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            MedManageCubit.get(context).deleteSecretaria(
                                user_id: model.secretary[index < 0 ? 0 : index].userId,
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: color5,
                            size: 35.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: model.secretary.length,
          )
          : Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.all(45.0),
              child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'No secretary to show',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }
}


/*Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .23,
                height: MediaQuery.of(context).size.height * .12,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade700,
                    //width: 2,
                  ),
                  borderRadius: BorderRadius.circular(350),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        //MedManageCubit.get(context).IndexPatientsList();
                        navigateAndReplacement(context, RegisterSecretaria());
                      },
                      icon: const Icon(
                        Icons.add,
                        color: color5,
                        size: 60.0,
                      ),
                      iconSize: MediaQuery.of(context).size.width * .13,
                    ),
                  ],
                ),
              ),
            )*/