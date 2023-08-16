import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manage_app/constant.dart';
import 'package:med_manage_app/cubit/cubit.dart';
import 'package:med_manage_app/cubit/states.dart';
import 'package:med_manage_app/layout/med_manage_layout.dart';
import 'package:med_manage_app/models/department/index_department_model.dart';
import 'package:med_manage_app/styles/colors/colors.dart';
import 'package:med_manage_app/widgets/component.dart';

import '../../helper/end_points.dart';

class AddDepartmentScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  final DepartmentHomeModel? model;
  final int index;

  AddDepartmentScreen({
    super.key,
    required this.model,
    required this.index,
  });
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit, MedManageStates>(
        builder: (context, state) {
          //nameController.text = model!.Department![index].name;
          MedManageCubit cubit = MedManageCubit.get(context);
          var departmentImage = MedManageCubit.get(context).departmentImage;

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Add Department',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              titleSpacing: 5.0,
              actions: [
                ConditionalBuilder(
                    condition: state is! MedManageLoadingAddDepartmentState,
                    builder: (context) => defTextButton(
                          text: 'add',
                          color: color4,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              MedManageCubit.get(context).postWithImage(
                                body: {
                                  'name': nameController.text,
                                },
                                imagePath: '$departmentImage',
                                endPoint: ADD_DEPARTMENT,
                                token: MedManageCubit.tokenOfAdmin,
                              );

                              MedManageCubit.get(context).getHomeDepData();

                              navigateAndReplacement(
                                  context, const MedManageLayout());
                            }
                          },
                        ),
                    fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        )),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Align(
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 170.0,
                                    child: departmentImage == null
                                        ? Image(
                                            image: NetworkImage(
                                                'http://$ipAddress:8000/upload/${model!.Department![index].img}',
                                                scale: 10.0),
                                          )
                                        : Image.file(
                                            File('$departmentImage').absolute,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: defaultColor,
                                    radius: 18.0,
                                    child: IconButton(
                                      onPressed: () {
                                        MedManageCubit.get(context).getImage();
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              cursorColor: defaultColor,
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: 'name of department',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: defaultColor,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              onFieldSubmitted: (String value) {},
                              onChanged: (String value) {
                                print(value);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'name mustn\'t be empty';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
