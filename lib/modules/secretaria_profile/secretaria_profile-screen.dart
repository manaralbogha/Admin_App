import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../layout/med_manage_layout.dart';
import '../../models/secretaria/index_secretaria_model.dart';
import '../../styles/colors/colors.dart';
import '../../widgets/component.dart';
import '../../widgets/secretaria_profile_item.dart';
import '../edit_secretaria_prof/edit_secretaria_prof_screen.dart';

class SecretariaProfile extends StatelessWidget {

  final IndexSecretariaModel? model;
  final int? index;

  const SecretariaProfile({
    super.key,
    this.model,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: color5,
              ),
              onPressed: (){
                MedManageCubit.get(context).indexSecretariaList();
                navigateAndReplacement(context, const MedManageLayout());
              },
            ),
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: defaultColor,
                letterSpacing: .3,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: 10.0,
                ),
                child: IconButton(
                  onPressed: (){
                    if(state is! MedManageErrorSecretariaProfState){
                      navigateTo(context, EditSecretariaProfScreen(index: index,));
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: color5,
                    size: 29.0,
                  ),
                ),
              ),
            ],
          ),
          body: ConditionalBuilder(
              condition: state is! MedManageLoadingSecretariaProfState,
              builder: (context) {
                return state is MedManageErrorSecretariaProfState ? const Center(
                  child: Text(
                    'There is some thing error',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
                    : Container(
                  padding: const EdgeInsetsDirectional.only(
                    start: 25.0,
                    end: 25.0,
                    top: 25.0,
                    bottom: 10.0,
                  ),
                  width: double.infinity,
                  child: ConditionalBuilder(
                      condition: state is! MedManageLoadingSecretariaProfState,
                      builder: (context) => SecretariaProfileItem(model: MedManageCubit.get(context).viewSecretariaModel,),
                      fallback: (context) => const Center(child: CircularProgressIndicator(),)
                  ),
                );
              },
              fallback: (context) => const Center(child: CircularProgressIndicator()),),
        );
      },
    );
  }
}