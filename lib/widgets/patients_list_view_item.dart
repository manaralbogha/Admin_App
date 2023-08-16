import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../models/patient/index_patient_model.dart';
import '../modules/patient_profile/patient_profile_screen.dart';
import '../styles/colors/colors.dart';
import 'component.dart';
import 'custome_image.dart';

class PatientsListViewItem extends StatelessWidget {

  final String? profImage;
  final IndexPatientModel model;


  const PatientsListViewItem(
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
            condition: state is! MedManageLoadingPatientsListState,
            builder: (context) => model.patient.isNotEmpty ?
            ListView.separated(
              itemBuilder: (context, index) =>
                  GestureDetector(
                    onTap: (){
                      MedManageCubit.get(context).viewPatient(
                        user_id: model.patient[index].userId,
                      );
                      navigateTo(context, const PatientProfileScreen());
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .14,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 15.0,
                          end: 8.0,
                          bottom: 15.0,
                        ),
                        child: Row(
                          children: [
                            CustomeImage(
                              image: 'assets/images/undraw_Female_avatar_efig (1).png',
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
                                        '${model.patient[index].user.firstName} ${model.patient[index].user.lastName}',
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
                                        model.patient[index].user.phoneNum,
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
                              onPressed: (){
                                MedManageCubit.get(context).deletePatient(
                                  user_id: model.patient[index].userId,
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
              itemCount: model.patient.length,
            )
                : Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.all(45.0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No patient to show',
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