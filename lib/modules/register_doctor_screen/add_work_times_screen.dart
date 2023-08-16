import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/api/services/local/cache_helper.dart';
import '../../core/functions/custome_dialogs.dart';
import '../../core/models/work_day_model.dart';
import '../../core/styles/colors/colors.dart';
import '../../core/styles/text_styles.dart';
import '../../core/widgets/custome_button.dart';
import '../../core/widgets/custome_error_widget.dart';
import '../../core/widgets/custome_progress_indicator.dart';
import '../../core/widgets/custome_text_field.dart';
import '../../main.dart';
import '../doctors_screen/doctors_screen.dart';
import 'manager/register_doctor_cubit.dart';
import 'manager/register_doctor_states.dart';

class AddWorkTimesView extends StatelessWidget {
  static const route = 'AddWorkTimesView';
  // final RegisterDoctorResponse registerDoctorResponse;
  final int doctorID;
  final List<WorkDayModel>? doctorTimes;
  const AddWorkTimesView({
    super.key,
    required this.doctorID,
    this.doctorTimes,
    // required this.registerDoctorResponse,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: doctorTimes == null
          ? (context) => RegisterDoctorCubit()
          : (context) =>
              RegisterDoctorCubit()..setComingDoctorTimes(list: doctorTimes!),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            doctorTimes == null ? 'Select Work Times' : 'Update Work Times',
          ),
        ),
        body: AddWorkTimesViewBody(
          doctorID: doctorID,
          doctorTimes: doctorTimes,
          // registerDoctorResponse: registerDoctorResponse,
        ),
      ),
    );
  }
}

class AddWorkTimesViewBody extends StatelessWidget {
  // final RegisterDoctorResponse registerDoctorResponse;
  final int doctorID;
  final List<WorkDayModel>? doctorTimes;
  const AddWorkTimesViewBody({
    super.key,
    required this.doctorID,
    this.doctorTimes,
    // required this.registerDoctorResponse,
  });

  @override
  Widget build(BuildContext context) {
    RegisterDoctorCubit cubit = BlocProvider.of(context);
    return BlocBuilder<RegisterDoctorCubit, RegisterDoctorStates>(
      builder: (context, state) {
        if (state is WorkTimesLoading) {
          return const CustomeProgressIndicator();
        } else if (state is WorkTimesFailure) {
          return CustomeErrorWidget(errorMsg: state.failureMsg);
        } else if (state is WorkTimesSuccess) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            cubit.close();
            if (doctorTimes != null && (doctorTimes?.isNotEmpty ?? false)) {
              Navigator.pop(context);
            } else {
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          });
          return DoctorsView(
            token: CacheHelper.getData(key: 'Token'),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenSize.height * .03),
                Container(
                  // height: screenSize.height * .8,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.only(bottom: 10),
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
                                    workDayModel: doctorTimes == null
                                        ? null
                                        : cubit.getDoctorWorkTimeModel(
                                            list: doctorTimes!,
                                            day: cubit.days[index],
                                          ),
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
                  text: doctorTimes == null ? 'Submit' : 'Update',
                  onPressed: () async {
                    if (cubit.val(context)) {
                      if (cubit.formKey.currentState!.validate()) {
                        if (doctorTimes != null) {
                          if (doctorTimes!.isNotEmpty) {
                            log('Testooooo');
                            await cubit.deleteDoctorWorkDays(list: doctorTimes);
                          }
                        }
                        cubit.storeTimes(
                          doctorID: '$doctorID',
                        );
                        await cubit.setWorkTimes(
                          doctorID: '$doctorID',
                        );
                        log('xxxxxxxxx');
                      }
                    }
                    log(doctorTimes.toString());
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
  final WorkDayModel? workDayModel;
  const _SelectTimeItem({
    required this.day,
    required this.indexR,
    this.workDayModel,
  });

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
        _CustomeTextField(
          indexR: indexR,
          type: 'From',
          // workDayModel: workDayModel,
        ),
        _CustomeTextField(
          indexR: indexR,
          type: 'To',
          // workDayModel: workDayModel,
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class _CustomeTextField extends StatefulWidget {
  final int indexR;
  final String type;
  // WorkDayModel? workDayModel;
  const _CustomeTextField({
    required this.indexR,
    required this.type,
    // this.workDayModel,
  });

  @override
  State<_CustomeTextField> createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<_CustomeTextField> {
  String? _hintText;

  @override
  Widget build(BuildContext context) {
    RegisterDoctorCubit cubit = BlocProvider.of(context);
    _hintText = cubit.workTimes[cubit.days[widget.indexR]][widget.type];
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
                if (s == '__') {
                  return 'required';
                }
              }
              return null;
            },
            focusNode: AlwaysDisabledFocusNode(),
            onTap: () {
              if (_hintText == '__') {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      content: SingleChildScrollView(
                        child: SizedBox(
                          child: Column(
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
                                  log('Hint Texxxxxxxxt = $_hintText');
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                setState(() {
                  cubit.workTimes[cubit.days[widget.indexR]][widget.type] =
                      '__';
                });
              }
            },
            decoration: InputDecoration(
              hintText: _hintText,
              hintStyle: TextStyle(fontSize: 11.w, fontWeight: FontWeight.w500),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              suffixIcon: _hintText == '__'
                  ? const Icon(
                      Icons.expand_more_sharp,
                      size: 40,
                      color: defaultColor,
                    )
                  : const Icon(
                      Icons.close,
                      size: 30,
                      color: defaultColor,
                      // :
                    ),
            ),
          ),
        );
      },
    );
  }
}
