import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_one_admin_app/core/functions/custome_dialogs.dart';
import 'package:project_one_admin_app/core/styles/text_styles.dart';
import 'package:project_one_admin_app/core/widgets/custome_button.dart';
import 'package:project_one_admin_app/core/widgets/custome_text_field.dart';
import 'package:project_one_admin_app/main.dart';
import 'package:project_one_admin_app/screens/register_doctor_screen/manager/register_doctor_cubit.dart';
import 'package:project_one_admin_app/screens/register_doctor_screen/manager/register_doctor_states.dart';
import '../../core/styles/colors/colors.dart';

class AddWorkTimesView extends StatelessWidget {
  static const route = 'AddWorkTimesView';
  const AddWorkTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterDoctorCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Select Work Times')),
        body: const AddWorkTimesViewBody(),
      ),
    );
  }
}

class AddWorkTimesViewBody extends StatelessWidget {
  const AddWorkTimesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterDoctorCubit cubit = BlocProvider.of(context);
    return BlocBuilder<RegisterDoctorCubit, RegisterDoctorStates>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(height: screenSize.height * .03),
            Container(
              height: screenSize.height * .75,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Days',
                          style: TextStyles.textStyle25
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          'From',
                          style: TextStyles.textStyle25
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          'To',
                          style: TextStyles.textStyle25
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.w),
                    Form(
                      key: cubit.formKey,
                      child: Column(
                        children: List.generate(
                          cubit.days.length,
                          (index) => Column(
                            children: [
                              const SizedBox(height: 10),
                              _SelectTimeItem(
                                  day: cubit.days[index], indexR: index),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenSize.height * .03),
            CustomeButton(
              text: 'Submit',
              onPressed: () {
                cubit.val(context: context);
                if (cubit.formKey.currentState!.validate()) {
                  log('OK');
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class _SelectTimeItem extends StatelessWidget {
  final String day;
  final int indexR;
  const _SelectTimeItem({required this.day, required this.indexR});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: screenSize.width * .3,
          child: Text(
            day,
            style: TextStyles.textStyle25,
            maxLines: 1,
          ),
        ),
        _CustomeTextField(indexR: indexR, type: 'From'),
        _CustomeTextField(indexR: indexR, type: 'To'),
      ],
    );
  }
}

class _CustomeTextField extends StatefulWidget {
  final int indexR;
  final String type;

  const _CustomeTextField({required this.indexR, required this.type});

  @override
  State<_CustomeTextField> createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<_CustomeTextField> {
  String? _hintText;
  @override
  Widget build(BuildContext context) {
    RegisterDoctorCubit cubit = BlocProvider.of(context);
    return BlocBuilder<RegisterDoctorCubit, RegisterDoctorStates>(
      builder: (context, state) {
        return SizedBox(
          width: screenSize.width * .3,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                String s = cubit.validatorHelper(
                  index: widget.indexR,
                  type: widget.type,
                );
                // log(s);
                if (s.isEmpty) {
                  return 'required';
                }
              }
              return null;
            },
            focusNode: AlwaysDisabledFocusNode(),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    content: SizedBox(
                      height: screenSize.height * .75,
                      child: GridView.count(
                        padding: EdgeInsets.zero,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        children: List.generate(
                          cubit.times.length,
                          (index) => CustomeDialogs.timeDialogButton(context,
                              onTap: () {
                            _hintText = cubit.times[index];

                            cubit.selectTime(
                              time: cubit.times[index],
                              index: widget.indexR,
                              type: widget.type,
                            );
                            Navigator.pop(context);
                          }, time: cubit.times[index]),
                        ),
                      ),
                    ),
                  );
                },
              );

              // CustomeDialogs.showTimesDialog(context);
            },
            decoration: InputDecoration(
              hintText: _hintText ?? '__',
              hintStyle: TextStyle(fontSize: 11.w),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              suffixIcon: const Icon(
                Icons.expand_more_sharp,
                size: 40,
                color: defaultColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
