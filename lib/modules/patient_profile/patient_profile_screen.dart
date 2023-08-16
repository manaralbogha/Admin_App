import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../layout/med_manage_layout.dart';
import '../../models/patient/index_patient_model.dart';
import '../../styles/colors/colors.dart';
import '../../widgets/component.dart';
import '../../widgets/patient_profile_item.dart';

class PatientProfileScreen extends StatelessWidget {

  final IndexPatientModel? model;
  final int? index;

  const PatientProfileScreen({
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
        if(state is MedManageErrorPatientsProfState)
        {
          return const Center(
            child: Text(
              'There is some thing error',
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }else
        {
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
                  MedManageCubit.get(context).indexPatientsList();
                  navigateAndReplacement(context, const MedManageLayout());              },
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
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsetsDirectional.only(
                  start: 25.0,
                  end: 25.0,
                  top: 25.0,
                  bottom: 25.0,
                ),
                width: double.infinity,
                child: ConditionalBuilder(
                    condition: state is! MedManageLoadingPatientsProfState,
                    builder: (context) => PatientProfileItem(model: MedManageCubit.get(context).viewPatientModel,),
                    fallback: (context) => const Center(child: CircularProgressIndicator(),)
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
