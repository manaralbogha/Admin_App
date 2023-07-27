import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_one_admin_app/core/api/services/register_doctor_service.dart';
import 'package:project_one_admin_app/core/functions/custome_dialogs.dart';
import 'package:project_one_admin_app/core/styles/text_styles.dart';
import 'package:project_one_admin_app/core/widgets/custome_button.dart';
import 'package:project_one_admin_app/core/widgets/custome_error_widget.dart';
import 'package:project_one_admin_app/core/widgets/custome_progress_indicator.dart';
import 'package:project_one_admin_app/core/widgets/custome_text_field.dart';
import 'package:project_one_admin_app/main.dart';
import 'package:project_one_admin_app/screens/register_doctor_screen/manager/register_doctor_cubit.dart';
import 'package:project_one_admin_app/screens/register_doctor_screen/manager/register_doctor_states.dart';
import '../../core/styles/colors/colors.dart';

class AddWorkTimesView extends StatelessWidget {
  static const route = 'AddWorkTimesView';
  final RegisterDoctorResponse registerDoctorResponse;
  const AddWorkTimesView({super.key, required this.registerDoctorResponse});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterDoctorCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Select Work Times')),
        body: AddWorkTimesViewBody(
            registerDoctorResponse: registerDoctorResponse),
      ),
    );
  }
}

class AddWorkTimesViewBody extends StatelessWidget {
  final RegisterDoctorResponse registerDoctorResponse;
  const AddWorkTimesViewBody({super.key, required this.registerDoctorResponse});

  @override
  Widget build(BuildContext context) {
    RegisterDoctorCubit cubit = BlocProvider.of(context);
    return BlocBuilder<RegisterDoctorCubit, RegisterDoctorStates>(
      builder: (context, state) {
        if (state is AddWorkTimesLoading) {
          return const CustomeProgressIndicator();
        } else if (state is AddWorkTimesFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is AddWorkTimesSuccess) {
          return ListView.builder(
            itemBuilder: (context, index) => Text(
              '${state.workTimes[index].day}  ${state.workTimes[index].startTime}  ${state.workTimes[index].endTime}',
            ),
            itemCount: state.workTimes.length,
          );
        } else {
          return SingleChildScrollView(
            child: Column(
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
                        SizedBox(height: 20.w),
                        Form(
                          key: cubit.formKey,
                          child: Column(
                            children: List.generate(
                              cubit.days.length,
                              (index) => Column(
                                children: [
                                  const SizedBox(height: 10),
                                  _SelectTimeItem(
                                    day: cubit.days[index],
                                    indexR: index,
                                  ),
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
                    if (cubit.val(context)) {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.storeTimes(
                            doctorID: '${registerDoctorResponse.doctorID}');
                        cubit.setWorkTimes(
                            doctorID: '${registerDoctorResponse.doctorID}');
                      }
                    }
                  },
                ),
                SizedBox(height: screenSize.height * .03),
              ],
            ),
          );
        }
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
            style: TextStyles.textStyle25.copyWith(fontSize: 19.sp),
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
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        widget.type == 'From'
                            ? cubit.times.length
                            : cubit.nextTimes.length,
                        (index) => CustomeDialogs.timeDialogButton(
                          context,
                          time: widget.type == 'From'
                              ? cubit.times[index]
                              : cubit.nextTimes[index],
                          onTap: () {
                            if (widget.type == 'From') {
                              cubit.nextTimesIndex = index;
                            }
                            // cubit.setNextTimes();
                            if (widget.type == 'From') {
                              _hintText = cubit.times[index];
                            } else {
                              _hintText = cubit.nextTimes[index];
                            }

                            cubit.selectTime(
                              time: widget.type == 'From'
                                  ? cubit.times[index]
                                  : cubit.nextTimes[index],
                              index: widget.indexR,
                              type: widget.type,
                            );
                            cubit.setNextTimes();
                            // if (widget.type == 'To') {
                            cubit.allTimes = !cubit.allTimes;
                            // }
                            Navigator.pop(context);
                            log('Next Times Length = ${cubit.nextTimes.length}');
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            decoration: InputDecoration(
              hintText: _hintText ?? '__',
              hintStyle: TextStyle(fontSize: 11.w, fontWeight: FontWeight.w500),
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
